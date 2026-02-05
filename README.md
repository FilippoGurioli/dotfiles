# Dotfiles

## Usage

Clone this repo into your home directory:

```bash
cd ~
git clone git@github.com:FilippoGurioli/dotfiles.git
```

Then, use `stow` command to symlink the configuration files:

```bash
cd ~/dotfiles
stow .
```

If the stow command doesn't succeed is because there are already files in your home directory with the same name as the ones in this repo. You can either delete them or move them to a different location.

If you want to be conservative, you could change temporarely the name of those files to `<filename>.bak` and then run the `stow` command.

If you know what you are doing, you can use the `--adopt` flag to let `stow` overwrite the existing files.

```bash
cd ~/dotfiles
stow --adopt .
```

After done that, trigger the themer feature to generate the theme files:

```bash
cd ~/dotfiles/themer
./update-theme.sh
```

You can also trigger the `update-theme.sh` script using `$mainMod+R` key combination, as it is bound in the `hyprland.conf` file.

## Themer

Going through ricing hyprland I've noticed that many times I had to repeat color values, fonts and other theme-based infos. To improve this, having a single source of truth in which declare all the style you want, I've created `themer`.

Starting from `my-theme.scss` in which you define all your variables with your preferred style, themer transpiles it into 2 different formats to adhere to all the configuration flavours I've found since now.

Launch `update-theme.sh` to generate the new files. The files will be generated in the `themer/lib/autogen` directory.

### Style formats

Since now I've found 3 different formats that are used in hyprland environment:

- `css`: used by wofi and waybar. This is the easiest format to convert to. In order to inject the variables declared in `my-theme.scss`, just import the corresponding style sheets and compile them with `sassc` (remember to set as output directory the correct one - e.g. `~/.config/wofi/style.css`).
- `hypr*.conf`: used by hyprland and hyprlock. This is a custom format that supports variables. To inject styles, import the generated `themer/lib/autogen/my-theme.conf` file in the hyprland configuration files as I did for example in `~/.config/hypr/hyprland.conf`.
- `custom`: used by kitty and waybar. Even though waybar has style.css file it could happen that style is declared in the `config` file too. In the other hand, kitty has a .conf file but does not allow variables as hypr compliants do. To inject style there you should first source `themer/lib/autogen/my-theme.sh` and then launch `lib/expand-env-vars.sh` passing the input file (with env vars in it) and the output file (i.e. where the expanded-vars file should stay).

The result is very clear and summed up in the `update-theme.sh` file:

```bash
#!/bin/bash

# easiest: just compile scss and output to the right location | remember to import your my-theme.scss in this files to exploits variables
sassc ~/.config/themer/wofi.scss   ~/.config/wofi/style.css
sassc ~/.config/themer/waybar.scss ~/.config/waybar/style.css

# themer core: generate my-theme.sh (for custom files) and my-theme.conf (for hypr*.conf)
~/.config/themer/libs/parse-scss-vars.sh ~/.config/themer/my-theme.scss
source ~/.config/themer/libs/autogen/my-theme.sh

# custom files: exploits expand-env-vars.sh with a file that uses variables to output a valid configuration file to its right location
~/.config/themer/libs/expand-env-vars.sh ~/.config/themer/kitty.conf ~/.config/kitty/kitty.conf
~/.config/themer/libs/expand-env-vars.sh ~/.config/themer/waybar.json ~/.config/waybar/config
```

### Notes

- If a new css is added, just add the corresponding `sassc` command in the `update-theme.sh` file.
- If a new `hypr*.conf` is added, just add the corresponding `source` command in the `hypr*.conf` file.
- If a new custom file is added, create a new file in the `themer` directory with the not-expanded variables and add the corresponding `expand-env-vars.sh` command in the `update-theme.sh` file.

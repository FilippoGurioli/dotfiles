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

It has also been developed a tool that updates all colors across the hyprland environment. This though to work properly requires that `$mainMod` + `R` is pressed at the very first time after the installation of the dotfiles.

This feature lets you change the colors and other configurations just in one file: `.config/themer/my-theme.scss`. After done that, use `$mainMod` + `R` to apply the changes.

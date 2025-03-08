# Dotfiles

## Usage

Clone this repo into your home directory:

```bash
cd ~
git clone --recursive git@github.com:FilippoGurioli/dotfiles.git
```

The `recursive` flag is necessary to clone the submodules as well.

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

## Files

- `.zshrc`: Zsh configuration file
- `.p10k.zsh`: Powerlevel10k configuration file
- `.gitconfig`: Global git configuration file
- `.oh-my-zsh`: Oh My Zsh configuration directory with custom plugins and themes inserted as submodules

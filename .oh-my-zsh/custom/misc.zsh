# Enable zoxide for directory navigation
eval "$(zoxide init --cmd cd zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up fzf key bindings (ctrl+r=history, ctrl+t=directories) and fuzzy completion
source <(fzf --zsh)

# Start tty saver with a custom logo after 30 minutes of inactivity
eval `ttysvr logo tty --init 1800`

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
show_fortune() {
	fortune -o | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1)
	add-zsh-hook -d precmd show_fortune
}
add-zsh-hook precmd show_fortune

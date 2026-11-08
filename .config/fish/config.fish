if status is-interactive
    set -Ux EDITOR nvim
    set -g fish_greeting
    echo "Welcome,"(set_color green)" $USER!"
    starship init fish | source

    # EZA
    alias ls="eza --icons=auto --group-directories-first"
    alias ll="eza -lh --icons=auto --group-directories-first --git"
    alias la="eza -lah --icons=auto --group-directories-first --git"
    alias tree="eza --tree --icons=auto"

    # FZF
    set -gx FZF_DEFAULT_OPTS "\
        --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7 \
        --color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff \
        --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
        --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a \
        --height 40% --layout=reverse --border rounded"
    set -gx FZF_CTRL_T_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --level=2 --color=always --icons=auto {}'"
    fzf --fish | source

    # ZOXIDE
    zoxide init fish | source
    alias cd="z"

    # RIPGREP
    alias grep="rg"
    alias mfd="zi"

    # MISC
    alias stfu="shutdown now"

    # Fast Node Manager
    fish_add_path ~/.local/share/fnm
    fnm env --use-on-cd | source

    # pnpm setup
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    fish_add_path $PNPM_HOME
    fish_add_path "$PNPM_HOME/bin"
    # pnpm end

    # opencode
    fish_add_path /home/rioly/.opencode/bin
end

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# export PATH="$PATH:$HOME/Unity/Hub/Editor/2021.3.21f1/Editor"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git 
#        zsh-autosuggestions - unusable with ttysvr
        zsh-syntax-highlighting
        )

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#AAAAAA'
ZSH_AUTOSUGGEST_STRATEGY='history completion'
ZSH_HIGHLIGHT_STYLES[path]='none'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

code() {
  TARGET_DIR="${1:-.}"
  # Find a .code-workspace file in the directory (only one, prefer exact match)
  WORKSPACE_FILE=$(find "$TARGET_DIR" -maxdepth 1 -type f -name '*.code-workspace' | head -n 1)
  if [[ -n "$WORKSPACE_FILE" ]]; then
    # Open the workspace files
    command code "$WORKSPACE_FILE"
  else
    # No workspace found, open the directory as-is
    command code "$TARGET_DIR"
  fi
}

brrrr() {
  ( aplay -c 2 -f u8 -r 44100 ~/Music/roomba.wav & ) &> /dev/null
  for (( i=1; i<=$(tput lines); i++ )) do
    tput cup $(( $(tput lines) - $i )) 0 && tput ed
    sleep 0.05
  done
  clear
}

zshconfig() {
  code ~/.zshrc
}

# ideaCommand() {
#   idea $1 > /dev/null 2>&1 &
# }

fileExplorer() {
  nautilus $1 > /dev/null 2>&1 &
}

alias whereami="pwd"
# alias code="code $1 --enable-proposed-api GitHub.copilot --enable-proposed-api GitHub.copilot-chat" - net needed anymore since I've installed the official vsc (not the OSS)
#alias docker="sudo docker" - not needed anymore since sudo usermod -aG docker $USER
alias prolog="java -jar ~/Documents/Unibo/PPS/Labs/2p-4.0.3.jar"
# alias cat="bat"
# alias idea="ideaCommand"
alias fx="fileExplorer"
alias scala="scala3"
alias roomba="brrrr"
alias stfu="shutdown now"
alias gs="git status"
alias gd="git diff --output-indicator-new ' ' --output-indicator-old=' '"
alias gl="git log --graph --all --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"

eval "$(zoxide init --cmd cd zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

eval `ttysvr logo tty --init 300`

# neofetch
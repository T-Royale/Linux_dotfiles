# Zinit initialization
source ~/.zsh/zinit/zinit.zsh

# ZSH_PLUGINS
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

# KeyBindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Opciones adicionales
setopt autocd
setopt cdablevars

# Completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Init oh-my-pos# Init oh-my-poshh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

export VISUAL=nvim
export EDITOR=nvim

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ZSH_TMUX_FIX=1

export hello=/usr/local/bin/t_royale

ENABLE_CORRECTION="true"

cls(){
	clear
	/usr/local/bin/t_royale
}

forceLoad(){
	hyprctl dispatch focuswindow $1
}

noClose(){
	if [ $# -ne 1 ]; then
		echo -e "SYNTAX: noClose [program]\nERROR: \"noClose\" needs an argument \nEXAMPLE: noClose waybar"
		exit 1	
	fi
	nohup "$1" > /dev/null 2>&1 & disown
}

if [[ $TERM_PROGRAM == "vscode" || $TERM_PROGRAM == "tmux" ]]; then
	/usr/local/bin/t_royale
else
	neofetch --source ~/.config/neofetch/logo.txt
fi

exercism () {
    local out
    readarray -t out < <(command exercism "$@")
    printf '%s\n' "${out[@]}"
    if [[ $1 == "download" && -d "${out[-1]}" ]]; then
        cd "${out[-1]}" || return 1
    fi
}

bash_test() {
    BATS_RUN_SKIPPED=true command bats *.bats
}

# Aliases
alias cd='z'
alias zi='cd "$(zoxide query -i)"'
alias vim='nvim'
alias neofetch='neofetch --ascii "$(cat ~/.config/neofetch/logo.txt)"'
alias ls='eza -s=modified --git'
alias tree='eza --tree --level=5'
alias tconfig='vim ~/.zshrc'
alias hconfig='vim ~/.config/hypr/hyprland.conf'
alias trefresh='source ~/.zshrc'
alias clock='termclock --time-format="%H:%M" --no-sysinfo --no-logo --no-date -nm'
alias video='vlc'
alias calc='rofi -show calc -modi calc -no-show-match -no-sort'
alias stouch='install -m 774 /dev/null'
alias q='exit 0'
alias code='codium'
alias cat='ccat'
alias image='feh'
alias grep='grep -i'
alias date='date +'%d/%m/%Y''
alias gs='git status --short'
alias gparted='pkexec env DISPLAY=$DISPLAY WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR gparted'
alias weather='curl wttr.in/valencia'
alias rm='/usr/local/bin/moveToTrash.sh'
alias cal='cal -m'
alias la='ls -a'
# PATH
export PATH="$HOME/.local/share/gem/ruby/3.3.0/bin:$PATH"
export PATH="/usr/bin/teoscripts:$PATH"
export PATH="$HOME/teo/teoscripts:$PATH"
export PATH="$HOME/bin:$PATH"

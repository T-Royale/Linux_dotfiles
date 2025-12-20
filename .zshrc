# Zinit initialization
source ~/.zsh/zinit/zinit.zsh

# ZSH_PLUGINS
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait'1' lucid
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit
compinit -C -d ~/.cache/zsh/zcompdump

# KeyBindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# --- Historial por prefijo con ↑ ↓ ---
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search   # ↑
bindkey '^[[B' down-line-or-beginning-search # ↓

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
eval "$(zoxide init zsh)"

# zsh fzf
source /usr/share/fzf/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/completion.zsh 2>/dev/null

export VISUAL=nvim
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ZSH_TMUX_FIX=1
export hello=/usr/local/bin/t_royale

ENABLE_CORRECTION="true"

fuck() {
  eval "$(thefuck --alias)"
  fuck "$@"
}

# Run program on background
noClose(){
    if [ $# -ne 1 ]; then
        echo -e "SYNTAX: noClose [program]\nERROR: \"noClose\" needs an argument \nEXAMPLE: noClose waybar"
        exit 1	
    fi
    nohup "$1" > /dev/null 2>&1 & disown
}

cls() {
    clear
    if [ "$columns" -ge "$MAX_LINES_NF" ] && [ "$lines" -ge "$MAX_COLS_NF" ]; then
        neofetch --ascii ~/.config/neofetch/logo.txt
    else
        /usr/local/bin/t_royale
    fi
}

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

# Start yazi from CLI and go to that directory after closing yazi 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Init oh-my-pos# Init oh-my-poshh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Aliases
alias mount_ntfs='sudo mount -t exfat -o uid=$(id -u),gid=$(id -g),umask=022'
alias df='df -ah'
alias fm='yazi'
alias lgit='lazygit'
alias cd='z'
alias zi='cd "$(zoxide query -i)"'
alias vim='nvim'
alias neofetch='neofetch --ascii "$(cat ~/.config/neofetch/logo.txt)"'
alias ls='eza -s=modified --git --icons'
alias tree='eza --tree --level=5'
alias tconfig='vim ~/.zshrc'
alias hconfig='vim ~/.config/hypr/hyprland.conf'
alias trefresh='source ~/.zshrc'
alias clock='termclock --time-format="%H:%M" --no-sysinfo --no-logo --no-date -nm'
alias video='vlc'
alias calc='rofi -show calc -modi calc -no-show-match -no-sort'
alias q='exit 0'
alias code='codium'
alias cat='bat --theme="Catppuccin Macchiato"'
alias image='feh'
alias grep='grep -i'
alias date="date +%d/%m/%Y"
alias gs='git status --short'
alias gparted='pkexec env DISPLAY=$DISPLAY WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR gparted'
alias weather='curl wttr.in/valencia'
alias rm='/usr/local/bin/moveToTrash.sh'
alias cal='cal -m'
alias la='ls -a'
alias open='xdg-open'
# PATH
path=(
  $HOME/.local/share/gem/ruby/3.3.0/bin
  /usr/bin/teoscripts
  $HOME/teo/teoscripts
  $HOME/bin
  $path
)

# Load local and secret variables
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# Init tmux and show neofetch if terminal is big enough

if [[ -o interactive && -z "$TMUX" ]] && command -v tmux >/dev/null; then
  session=$(
    tmux list-sessions -F '#{session_name} #{session_attached} #{session_created}' 2>/dev/null \
    | awk '$2 == 0 {print $3, $1}' \
    | sort -n \
    | tail -1 \
    | awk '{print $2}'
  )

  if [[ -n "$session" ]]; then
    tmux attach -t "$session"
  else
    tmux new
  fi
fi

NEOFETCH_CACHE="$HOME/.cache/neofetch.ascii"

if [[ -o interactive ]]; then
  if (( COLUMNS >= 80 && LINES >= 35 )); then
    if [[ -f $NEOFETCH_CACHE ]]; then
      /usr/bin/cat "$NEOFETCH_CACHE"
    else
      neofetch --ascii ~/.config/neofetch/logo.txt | tee "$NEOFETCH_CACHE"
    fi
  else
    /usr/local/bin/t_royale
  fi
fi


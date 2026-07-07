# === ПРОФИЛИРОВАНИЕ (Раскомментируй эту строку, если хочешь найти скрытые тормоза) ===
# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export QT_STYLE_OVERRIDE=Fusion
#export QSG_RHI_BACKEND=vulkan
#export QT_QPA_PLATFORMTHEME=qt6ct
export EDITOR=nvim
export GPG_TTY=$(tty)
export ZSH_COMPDUMP="/tmp/.zcompdump-$HOST"

autoload -Uz compinit
compinit -d ~/.zcompdump

export ZSH_COMPDUMP="/tmp/.zcompdump-$HOST"

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
gpg-connect-agent updatestartuptty /bye >/dev/null

# Development environment variables
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

# Enhanced aliases for development
alias scron="su -c $(printf "%q " "crontab -e")"
alias poweroff-update="paru -Syu --noconfirm; poweroff"
alias vim="nvim"
alias copy='wl-copy'
alias paste='wl-paste'
alias pass-paste="pass Sber/Sber-Solution/comp/comp -c && ~/work/clip.sh clip"
alias pass-gf="pass git fetch"
alias pass-gs="pass git status"
alias pass-gl="pass git pull"
alias pass-gp="pass git push"
alias lli='ls -lhi'

# Development aliases
alias gst="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gd="git diff"
alias glog="git log --oneline --graph --decorate"
alias gstash="git stash"
alias gpop="git stash pop"

# Docker aliases
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dex="docker exec -it"
alias dlogs="docker logs"
alias dstop="docker stop"
alias drm="docker rm"

# System aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# File management
alias mkdir="mkdir -p"
alias cp="cp -r"
alias rm="rm -i"
alias mv="mv -i"

# Network and system
alias ports="netstat -tulanp"
alias myip="curl -s https://ipinfo.io/ip"
alias weather="curl -s wttr.in"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# Development tools
alias py="python3"
alias pip="pip3"
alias node-repl="node --experimental-repl-await"
alias npm-global="npm list -g --depth=0"

# Password generation functions
function pwg() {
    tr -dc 'A-Za-z0-9_!@#$%^&*()' < /dev/urandom | head -c $1 | xargs
}
function pwg-char() {
    tr -dc 'A-Za-z0-9' < /dev/urandom | head -c $1 | xargs
}

# Development helper functions
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function git-branch-cleanup() {
    git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
}

function docker-cleanup() {
    docker system prune -f
    docker volume prune -f
    docker image prune -f
}

function find-in-files() {
    find . -type f -name "*$1*" -exec grep -l "$2" {} \;
}

function app() {
    nohup proxychains4 "$1" &!
}

# Set name of the theme to load
ZSH_THEME="mortalscumbag"

# Which plugins would you like to load?
# УБРАН zsh-autocomplete: он известен тем, что вызывает сильные тормоза и конфликты с autosuggestions.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search sudo jsontools pass rsync fzf history systemd systemadmin docker docker-compose npm node pip python)

source $ZSH/oh-my-zsh.sh

# Enhanced history settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete

# Auto-completion for custom functions
autoload -U +X bashcompinit && bashcompinit

# Load fzf (оставили только один вызов вместо трех)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# === Цветовая палитра (единая точка управления) ===
typeset -gA PROMPT_COLORS
PROMPT_COLORS=(
  host        "%F{green}%B"
  branch      "%F{magenta}"
  staged      "%F{yellow}"
  unstaged    "%F{red}"
  untracked   "%F{blue}"
  venv        "%F{cyan}%B"
  success     "%F{green}"
  error       "%F{red}%B"
  reset       "%b%f"
)

# === Глобальные переменные (состояние между вызовами) ===
typeset -g CMD_START_TIME=0
typeset -g CMD_EXEC_TIME=0
typeset -g LAST_PGP_CHECK=0
typeset -g LAST_DOCKER_CHECK=0
typeset -g PGP_CACHE_AGE=5
typeset -g DOCKER_CACHE_AGE=10
typeset -g PGP_UNLOCKED=1
typeset -g DOCKER_STATUS=""
typeset -g RET_STATUS=0

# === Индикаторы ===
_toolbox_prompt_info() {
  [[ -n "$TOOLBOX_PATH" || -n "$container" ]] && echo "⬢ "
}

ssh_connection() {
  [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && echo "🌐 "
}

my_git_prompt() {
  git rev-parse --git-dir >/dev/null 2>&1 || return
  
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || \
           git describe --tags --exact-match 2>/dev/null || \
           echo "(detached)")
  
  local indicators=()
  
  git diff --cached --quiet 2>/dev/null || indicators+=("${PROMPT_COLORS[staged]}●${PROMPT_COLORS[reset]}")
  git diff --quiet 2>/dev/null || indicators+=("${PROMPT_COLORS[unstaged]}●${PROMPT_COLORS[reset]}")
  git ls-files --others --exclude-standard --error-unmatch 2>/dev/null | grep -q . && \
    indicators+=("${PROMPT_COLORS[untracked]}●${PROMPT_COLORS[reset]}")
  
  if (( ${#indicators[@]} )); then
    echo " ${PROMPT_COLORS[branch]}‹ ${branch} ${(j::)indicators} ›${PROMPT_COLORS[reset]}"
  else
    echo " ${PROMPT_COLORS[branch]}‹ ${branch} ›${PROMPT_COLORS[reset]}"
  fi
}

exec_time_prompt() {
  (( CMD_EXEC_TIME > 2000 )) || return
  
  local total_ms=$((CMD_EXEC_TIME))
  local sec=$((total_ms / 1000))
  
  if (( sec < 10 )); then
    echo " ⏱️ $(printf "%.2f" "$((total_ms))e-3")s"
  fi
}

venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo " ${PROMPT_COLORS[venv]}(${VIRTUAL_ENV:t})${PROMPT_COLORS[reset]}"
  elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    echo " ${PROMPT_COLORS[venv]}(${CONDA_DEFAULT_ENV})${PROMPT_COLORS[reset]}"
  fi
}

sudo_prompt() {
  sudo -n true 2>/dev/null && echo " 🔑"
}

pgp_prompt() {
  [[ -d ~/.password-store ]] || return
  
  (( EPOCHSECONDS - LAST_PGP_CHECK < PGP_CACHE_AGE )) || {
    local first_entry
    first_entry=$(find ~/.password-store -name "*.gpg" -type f 2>/dev/null | head -n1)
    
    if [[ -n "$first_entry" ]]; then
      gpg --pinentry-mode cancel --batch --quiet --decrypt "$first_entry" 2>/dev/null >/dev/null
      PGP_UNLOCKED=$?
    else
      PGP_UNLOCKED=0
    fi
    
    LAST_PGP_CHECK=$EPOCHSECONDS
  }
  
  (( PGP_UNLOCKED == 0 )) && echo " 🔓"
}

docker_prompt() {
  (( EPOCHSECONDS - LAST_DOCKER_CHECK < DOCKER_CACHE_AGE )) || {
    if docker info --format '{{.ServerVersion}}' >/dev/null 2>&1; then
      local running=$(docker ps -q 2>/dev/null | wc -l)
      DOCKER_STATUS=$([[ $running -gt 0 ]] && echo " 🐳${running}" || echo " 🐳")
    else
      DOCKER_STATUS=""
    fi
    LAST_DOCKER_CHECK=$EPOCHSECONDS
  }
  
  [[ -n "$DOCKER_STATUS" ]] && echo "$DOCKER_STATUS"
}

ret_status() {
  (( RET_STATUS == 0 )) && \
    echo "${PROMPT_COLORS[success]}${RET_STATUS}${PROMPT_COLORS[reset]}" || \
    echo "${PROMPT_COLORS[error]}${RET_STATUS}${PROMPT_COLORS[reset]}"
}

# === Хуки zsh ===
preexec() {
  CMD_START_TIME=$EPOCHREALTIME
}

precmd() {
  RET_STATUS=$?
  
  if [[ -n "$CMD_START_TIME" ]]; then
    local end_time=$EPOCHREALTIME
    CMD_EXEC_TIME=$(( (end_time - CMD_START_TIME) * 1000 ))
    unset CMD_START_TIME
  else
    CMD_EXEC_TIME=0
  fi
}

get_load_color() {
  awk -v n="$1" 'BEGIN {
    if (n < 1.0) print "green"
    else if (n < 2.0) print "yellow"
    else if (n < 3.0) print "orange"
    else print "red"
  }'
}

colored_uptime() {
  local cores=$(nproc 2>/dev/null || echo 1)
  local -a loads
  read -r -A loads < /proc/loadavg
  local parts=()
  for i in 1 2 3; do
    local norm=$(awk -v l="${loads[$i]}" -v c="$cores" 'BEGIN {printf "%.2f", l/c}')
    local color=$(get_load_color "$norm")
    parts+=("%F{$color}$norm%f")
  done
  echo "${(j: :)parts} [%F{blue}$cores%f]"
}

# PROMPT='$(_toolbox_prompt_info)$(ssh_connection)${PROMPT_COLORS[host]}%m${PROMPT_COLORS[reset]}$(my_git_prompt)$(venv_prompt)$(sudo_prompt)$(pgp_prompt)$(docker_prompt) : %~$(exec_time_prompt)
# [$(ret_status)] %# '

# === ПРОФИЛИРОВАНИЕ (Раскомментируй эту строку, чтобы увидеть отчет о тормозах) ===
# zprof | head -n 30

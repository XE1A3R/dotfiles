# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=nvim
export SDL_AUDIODRIVER=alsa
export GPG_TTY=$(tty)
export ZSH_COMPDUMP="/tmp/.zcompdump-$HOST"

autoload -Uz compinit
compinit -d ~/.zcompdump

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Development environment variables
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.npm-global/bin

# Node.js version management
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Python virtual environment
export PYTHONPATH="${PYTHONPATH}:$HOME/.local/lib/python3.*/site-packages"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Enhanced aliases for development

alias proxy="export http_proxy="http://127.0.0.1:9080"; export https_proxy="http://127.0.0.1:9080"; export ALL_PROXY="socks5://127.0.0.1:9050"; export no_proxy="localhost,127.0.0.1,192.168.1.0/24""
alias no-proxy="env --unset=http_proxy --unset=https_proxy --unset=HTTP_PROXY --unset=HTTPS_PROXY --unset=ALL_PROXY"
alias scron="su -c $(printf "%q " "crontab -e")"
alias poweroff-update="paru -Syu --noconfirm; poweroff"
alias vim="nvim"
alias copy="xclip -r -sel c"
alias paste="xclip -o -sel c"
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

function create-python-project() {
    mkcd "$1"
    python3 -m venv venv
    echo "venv/" > .gitignore
    echo "*.pyc" >> .gitignore
    echo "__pycache__/" >> .gitignore
    source venv/bin/activate
    echo "Python project '$1' created with virtual environment"
}

function create-node-project() {
    mkcd "$1"
    npm init -y
    echo "node_modules/" > .gitignore
    echo "*.log" >> .gitignore
    echo "dist/" >> .gitignore
    echo "Node.js project '$1' created"
}

function app() {
    nohup proxychains4 "$1" &!
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="zhann"
#ZSH_THEME="alanpeabody"
#ZSH_THEME="peepcode"
ZSH_THEME="mortalscumbag"

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
#plugins=(git)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete web-search sudo jsontools pass rsync fzf history systemd systemadmin docker docker-compose npm node pip python)
source $ZSH/oh-my-zsh.sh

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enhanced history settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Better completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete

# Auto-completion for custom functions
autoload -U +X bashcompinit && bashcompinit

# Load additional tools if available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/sasha/.dart-cli-completion/zsh-config.zsh ]] && . /home/sasha/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
if [ $machine = "Mac" ]; then
    
    alias v='vim'
    # Keep all work exports seprate
    source ~/.mac_zsh_source.sh

elif [ $machine = "Linux" ]; then
    
    alias vim='vimx'
    alias v='vimx'

    # Linux ZSH Install
    export ZSH=/home/kitty/.oh-my-zsh
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Vim keybindings for zsh
bindkey -v


# Setup the prompt elements on the left and right
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv custom_tw_count_week custom_tw_count_today custom_tw_count_overdue)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_tw_count vcs status root_indicator background_jobs custom_tiw custom_tiw_day time vi_mode)


# Custom prompt element to count all tasks in the current context
POWERLEVEL9K_CUSTOM_TW_COUNT="tw +READY count"

# Custom prompt element to count all tasks in the current context due this week
POWERLEVEL9K_CUSTOM_TW_COUNT_WEEK="tw -hold +READY +DUE count"

# Custom prompt element to count all tasks in the current context due today
POWERLEVEL9K_CUSTOM_TW_COUNT_TODAY="tw +READY due:eod count"
POWERLEVEL9K_CUSTOM_TW_COUNT_TODAY_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_TW_COUNT_TODAY_BACKGROUND="yellow"

# Custom prompt element to count all tasks in the current context that are overdue
POWERLEVEL9K_CUSTOM_TW_COUNT_OVERDUE="tw +OVERDUE +READY count"
POWERLEVEL9K_CUSTOM_TW_COUNT_OVERDUE_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_TW_COUNT_OVERDUE_BACKGROUND="red"

# Custom prompt element to display current task time tracking
POWERLEVEL9K_CUSTOM_TIW="tiw | grep 'Total' | awk '{print \$2}'"

# Custom prompt element to display current day timetracking
POWERLEVEL9K_CUSTOM_TIW_DAY="tiw summary :day | tail -n 2 | head -n 1 | awk '{print \$1}'"

# Overwrite default zsh context with a cat emoji to save space
POWERLEVEL9K_CONTEXT_TEMPLATE="🐱"

# Shorten directories in the middle if more then 3 folders deep
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER="."
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"


export VISUAL=vim
export EDITOR=vim

# Configure global github excludes
git config --global core.excludesfile ~/.gitignore_global


export FZF_DEFAULT_COMMAND='fd --exclude .git -H --type f'
#export FZF_DEFAULT_OPTS='--preview="pygmentize {}"'

# Functions and aliases
fh(){
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --preview="" | sed 's/ *[0-9]* *//')
}


fcd(){
    local dir
    dir=$(fd --type d --exclude .git |fzf +m --preview="ls -al --color {}")
    cd "$dir"
}

# Something something furry joke
bd(){
    system_wide_bookmarks=''
    user_bookmarks=''

    if [ -r /etc/bd.list ]; then
        system_wide_bookmarks=$(cat /etc/bd.list)
    fi
    if [ -r ~/.bd.list ]; then
        system_wide_bookmarks=$(cat ~/.bd.list)
    fi

    dest_dir=$(echo -e "$system_wide_bookmarks\n$user_bookmarks" | sed '/^\s*$/d' | fzf --height 30% --border --ansi | sed 's/#.*//g'| sed 's/\s*$//g' | sed 's/ *$//g' )
    cd "$dest_dir"
}

bda(){
    local curr_dir="${PWD} # $*"
    if ! grep -Fxq "$curr_dir" ~/.bd.list; then
        echo "$curr_dir" >> ~/.bd.list
    fi
}

# Git fzf commands
gtf() {
  git rev-parse HEAD > /dev/null 2>&1 || echo OwO
  git -c color.status=always status --short |
  fzf --height 50% "$@" --border -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gtb() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --height 50% "$@" --border --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gtc() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  git checkout $(git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --height 50% "$@" --border --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##')
}

gtm() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  git merge $(git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --height 50% "$@" --border --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##')
}


gtt() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  git tag --sort -version:refname |
  fzf --height 50% "$@" --border --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gth() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf --height 50% "$@" --border --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gtr() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf --height 50% "$@" --border --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

alias f='fzf'
alias fv='vim "$(fzf --preview="pygmentize {}")"'

alias tmux='tmux -2'
alias l='less'

# Custom task and time tracking aliases
alias tiw='timew'
alias tw='task'
alias twl='task ls'
alias twa='task add'

alias twp='task add project:personal'

if [ $machine = "Linux" ] ; then


    (cat ~/.cache/wal/sequences &)

    source /usr/share/zsh/site-functions/fzf
elif [ $machine = "Mac" ]; then
    source /usr/local/opt/fzf/shell/completion.zsh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

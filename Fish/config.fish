set -x PATH $PATH $HOME/.bin/ $HOME/.local/bin/
set -x VISUAL nvim
set -x EDITOR nvim

set -x GOPATH $HOME/Documents/Projects/Go
set -x GOROOT /usr/local/opt/go/libexec
set PATH $GOPATH/bin $GOROOT/bin $PATH

# FZF default command
set FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'

alias fgc='fzf_git_checkout_branch'

alias gpu='git stash push'
alias gpo='git stash pop'
alias awsp='aws_profile_select'

function __fasd_run -e fish_preexec -d 'fasd takes record of the directories changed into'
	command fasd --proc (command fasd --sanitize "$argv") > '/dev/null' 2>&1 &
end

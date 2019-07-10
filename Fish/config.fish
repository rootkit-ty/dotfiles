set -x PATH $PATH ~/.bin/ ~/.local/bin/
set -x VISUAL nvim
set -x EDITOR nvim

# FZF default command
set FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'

alias fgc="fzf_git_checkout_branch"


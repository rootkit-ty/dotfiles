function fzf_git_checkout_branch
	git rev-parse HEAD > /dev/null 2>&1; or return
	git branch -a --color=always | grep -v HEAD | string trim | fzf --height "50%" --border --ansi --tac --preview-window "right:70%" --preview 'git log --oneline --color=always --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {} | head -' | read -l result; and git checkout "$result"
end


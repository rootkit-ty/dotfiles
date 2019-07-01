function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _git_stash
  set -l stashes (command git stash list ^/dev/null | wc -l)
  [ $stashes != '0' ]; and echo -n (set_color bryellow)'^['$stashes']'
end

function fish_prompt
	test $SSH_TTY
	and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
	test "$USER" = 'root'
	and echo (set_color red)"#"

	if [ $fish_key_bindings = 'fish_vi_key_bindings' ]
		switch $fish_bind_mode
		case default
			set separator_color_1 brmagenta
			set separator_color_2 magenta
		case insert
			set separator_color_1 brcyan
			set separator_color_2 cyan
		case replace_one replace-o
			set separator_color_1 brblue
			set separator_color_2 blue
		case visual
			set separator_color_1 brred
			set separator_color_2 red
		end
	end

	# Main
	echo -n (set_color brmagenta)(prompt_pwd)

	# Branch name
	set_color brgreen; [ -z (_git_branch_name) ]; or printf '(%s)' (_git_branch_name)

	# Dirty detection
	set_color brred; [ -z (_is_git_dirty) ]; or echo -n '*'

	# Stash detection
	echo -n (_git_stash)

	# AWS profiles, so I know which client I might blow away
	# - Green if readonly
	# - Yellow if writeable
	# - Red if prod and writable
	set_color normal
	if [ -n "$AWS_PROFILE" ]
		if command env | grep 'AWS_PROFILE' | grep -P '\w{3,}-ro' > /dev/null
			echo -n (set_color -b green)
		else if command env |grep 'AWS_PROFILE' | grep -P '(?<!non)prod$' > /dev/null
			echo -n (set_color -b brred)
		else
			echo -n (set_color -b bryellow)
		end
		echo -n (set_color white)'{'$AWS_PROFILE'}'(set_color normal)
	end
	echo -n (set_color brblack)'❯'(set_color $separator_color_1)'❯'(set_color $separator_color_2)'❯ '
end

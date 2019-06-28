function fish_right_prompt
	set -l exit_code $status
	[ $exit_code -ne 0 ]; and echo -n (set_color brred)$exit_code(set_color brblack)'|'
	[ $CMD_DURATION -gt 1000 ]; and echo -n (set_color yellow)(echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')(set_color brblack)'|'
	set_color brblack
	echo (date +"%T")
	echo (set_color normal)
end

function aws_profile_select
	export AWS_PROFILE=(rg -Po "(?<=\[profile ).*(?=])" ~/.aws/config | fzf)
end


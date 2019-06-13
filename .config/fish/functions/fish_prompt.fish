function fish_prompt
	#set cmd_status $status

	set_color FC0
	if test (id -u) -eq 0
		set_color E00
	end
	echo -n $USER
	set_color normal
	echo -n '@'
	set_color 08F
	echo -n (hostname)
	set_color FD6
	echo -n '' (prompt_pwd) ''

	if type -q git
		set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
		if test -n "$git_dir"
			set_color green
			#echo -n '' (command git branch | grep \* | cut -d ' ' -f2- 2>/dev/null) ''
			echo -n '' (command git branch | sed -n '/\* /s///p' 2>/dev/null) ''
		end
	end

	set_color normal
	echo '⋟ '
end

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
	echo -n '' (prompt_pwd)

	if type -q git
		set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
		if test -n "$git_dir"
			set -l git_branch (command git branch | sed -n '/\* /s///p' 2>/dev/null)
			set -l git_remote (command git for-each-ref --format='%(upstream:short)' (command git symbolic-ref -q HEAD) origin/mainline)
			set -l git_ahead (command git rev-list --count $git_remote..$git_branch)
			set -l git_behind (command git rev-list --count $git_branch..$git_remote)
			set_color green
			echo -n "  $git_branch"
			if test "$git_ahead" -gt 0
				set_color FC0
				echo -n " ↑$git_ahead"
			end
			if test "$git_behind" -gt 0
				set_color F70
				echo -n " ↓$git_behind"
			end
		end
	end

	set_color normal
	echo ' ⋟ '
end

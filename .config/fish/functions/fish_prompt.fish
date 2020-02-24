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
		set -l git_branch
		set -l git_remote
		set -l git_ahead
		set -l git_behind
		if test -n "$git_dir"
			set git_branch (command git branch | sed -n '/\* /s///p' 2>/dev/null)
			set git_remote (command git for-each-ref --format='%(upstream:short)' (command git symbolic-ref -q HEAD) origin/mainline)
			if test -n "$git_branch" && test -n "$git_remote"
				set git_ahead (command git rev-list --count $git_remote..$git_branch 2>/dev/null)
				set git_behind (command git rev-list --count $git_branch..$git_remote 2>/dev/null)
			end
			set -l git_dirty (command git status -s 2>/dev/null)
			set -l git_staged (command git diff --cached | head 2>/dev/null)
			set -l git_stashed (command git stash list 2>/dev/null)

			set_color green
			if test -n "$git_dirty"
				set_color F70
			end
			echo -n " "
			if test -n "$git_branch"
				echo -n " $git_branch"
			end

			if test -n "$git_ahead" && test "$git_ahead" -gt 0
				set_color FC0
				echo -n " ↑$git_ahead"
			end
			if test -n "$git_behind" && test "$git_behind" -gt 0
				set_color F70
				echo -n " ↓$git_behind"
			end

			if test -n "$git_staged"
				set_color BFB
				echo -n " +"
			end

			if test -n "$git_stashed"
				set_color FC0
				echo -n " ⋮"
			end
		end
	end

	set_color normal
	echo ' ⋟ '
end

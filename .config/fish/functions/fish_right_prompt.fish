function fish_right_prompt
	set cmd_status $status

	if test $CMD_DURATION
		if test "$CMD_DURATION" -gt 60000
			echo "⌛ "
		end
		set_color 888
		if test "$CMD_DURATION" -gt 20000
			set_color FB0
		end
		if test "$CMD_DURATION" -gt 60000
			set_color E22
		end

		if test "$CMD_DURATION" -ge 86400000
			printf "%.1fd" (math "$CMD_DURATION / 1000 / 60 / 60 / 24")
		else if test "$CMD_DURATION" -ge 3600000
			printf "%.1fh" (math "$CMD_DURATION / 1000 / 60 / 60 % 24")
		else if test "$CMD_DURATION" -ge 60000
			printf "%.1fm" (math "$CMD_DURATION / 1000 / 60 % 60")
		else if test "$CMD_DURATION" -ge 1000
			printf "%.3fs" (math "$CMD_DURATION / 1000")
		else
			printf "%sms" $CMD_DURATION
		end

		set_color normal
	end

	if test "$cmd_status" -gt 0
		#echo " ❌"
		set_color red
		echo " ⤫"
	end
end

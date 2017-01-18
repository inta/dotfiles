#!/bin/sh

msg() {
	str=$1
	for color_num in $(echo "$str" | grep -Eo "%\d+%"); do
		color_num=$(echo "$color_num" | sed "s/%//g")
		if command -v tput > /dev/null; then
			color=$(tput setaf "$color_num")
			default=$(tput sgr0)
		fi
		str=$(echo "$str" | sed "s/%$color_num%/$color/")
	done
	printf "%s%s\n" "$str" "$default"
}

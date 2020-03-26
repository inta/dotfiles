function pwgen --description 'Generate a password'
	if contains -- --simple $argv
		set chars 'a-zA-Z0-9'
	else
		set chars 'a-zA-Z0-9!#$%&()*+,-./:;<=>?@[]^_{|}~'
	end
	if string match --quiet --regex --invert '\D' -- $argv[-1]
		set length $argv[-1]
	else
		set length 32
	end
	cat /dev/urandom | tr -dc $chars | fold -w $length | head -n 1
	#cat /dev/urandom | tr -dc 'a-zA-Z0-9!#$%&()*+,-./:;<=>?@[]^_{|}~' | fold -w 32 | head -n 1
end

function pwgen
	cat /dev/urandom | tr -dc 'a-zA-Z0-9!#$%&()*+,-./:;<=>?@[]^_{|}~' | fold -w 32 | head -n 1
end

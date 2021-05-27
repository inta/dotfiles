function composer --description 'getcomposer.org'
	docker run --rm -it --volume (pwd):/app --user (id -u):(id -g) composer $argv
end

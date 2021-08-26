function composer --description 'getcomposer.org'
	docker run --rm -it --volume (pwd):/app --user (id -u):(id -g) composer --ignore-platform-reqs $argv
end

function composer --description 'getcomposer.org'
	#docker run --rm -it --volume (pwd):/app --user (id -u):(id -g) nexus.webxells.com/composer --ignore-platform-reqs $argv
	docker run --rm -it --volume (pwd):/app --user (id -u):(id -g) nexus.webxells.com/composer $argv
end

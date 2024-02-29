function php --description 'Run php via docker'
	argparse 'v/version=' -- $argv
	if string match --quiet --regex '^\d+(\.\d+)?$' -- $_flag_v
		set php_tag $_flag_v-cli
	else
		set php_tag cli
	end
	set php_image php:$php_tag
	docker run --rm -it --volume (pwd):/app -w /app --user (id -u):(id -g) nexus.webxells.com/$php_image php $argv
end

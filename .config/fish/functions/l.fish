function l
	if type -q exa
		exa -la --git $argv
	else
		ls -lah $argv
	end
end

function ll
	if type -q exa
		exa -laT --git $argv
	else
		ls -lahR $argv
	end
end

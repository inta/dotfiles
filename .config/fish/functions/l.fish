function l
	if type -q eza
		exa -la --git $argv
	else
		ls -lah $argv
	end
end

function ll
	if type -q eza
		exa -laT --git $argv
	else
		ls -lahR $argv
	end
end

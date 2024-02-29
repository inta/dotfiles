function l
	if type -q eza
		eza -la --git $argv
	else
		ls -lah $argv
	end
end

function ll
	if type -q eza
		eza -laT --git $argv
	else
		ls -lahR $argv
	end
end

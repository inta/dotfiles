if test -d "$HOME/.cargo/bin"
	set PATH "$HOME/.cargo/bin" $PATH
end

if test -d "$HOME/.local/share/npm/bin"
	set PATH "$HOME/.local/share/npm/bin" $PATH
end

if test -d "$HOME/.dotfiles/.tools"
	set PATH "$HOME/.dotfiles/.tools" $PATH
end

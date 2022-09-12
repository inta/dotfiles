if test -d "$HOME/.cargo/bin"
	set PATH "$HOME/.cargo/bin" $PATH
end

if test -d "$HOME/.npm/global-modules/bin"
	set PATH "$HOME/.npm/global-modules/bin" $PATH
end

if test -d "$HOME/.dotfiles/.tools"
	set PATH "$HOME/.dotfiles/.tools" $PATH
end

if test -f "$HOME/.config/asound.state"
	alsactl --file ~/.config/asound.state restore 2>/dev/null
end

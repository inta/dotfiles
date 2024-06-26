if test -d "$HOME/.local/bin" && ! contains "$HOME/.local/bin" $PATH
	fish_add_path "$HOME/.local/bin"
end

if test -d "$HOME/.cargo/bin" && ! contains "$HOME/.cargo/bin" $PATH
	fish_add_path "$HOME/.cargo/bin"
end

if test -d "$HOME/.npm/global-modules/bin" && ! contains "$HOME/.npm/global-modules/bin" $PATH
	fish_add_path "$HOME/.npm/global-modules/bin"
end

if test -d "$HOME/.dotfiles/.tools" && ! contains "$HOME/.dotfiles/.tools" $PATH
	fish_add_path "$HOME/.dotfiles/.tools"
end

#if test -f "$HOME/.config/asound.state"
#	alsactl --file ~/.config/asound.state restore 2>/dev/null
#end

# bun
#if test -d "$HOME/.bun/bin"
#	set --export BUN_INSTALL "$HOME/.bun"
#	set --export PATH $BUN_INSTALL/bin $PATH
#end

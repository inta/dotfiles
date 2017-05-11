# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
	git clone https://github.com/zplug/zplug ~/.zplug
	source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

zplug "zplug/zplug"

# Load the oh-my-zsh's library.
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

# Bundles from the default repo (robbyrussell's oh-my-zsh).
zplug "plugins/git", from:oh-my-zsh, defer:3

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-history-substring-search"

# Load the theme.
#zplug "themes/jreese", from:oh-my-zsh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time time)
POWERLEVEL9K_MODE='awesome-fontconfig'
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

# Then, source plugins and add commands to $PATH
zplug load

if [ -d ~/.linuxbrew/bin ]; then
	PATH="$HOME/.linuxbrew/bin:$PATH"
fi

if [ -d ~/.node/bin ]; then
	PATH="$HOME/.node/bin:$PATH"
fi
if [ -d ~/.local/share/npm ]; then
	PATH="$HOME/.local/share/npm/bin:$PATH"
fi

export PATH="$HOME/.dotfiles/.tools:$PATH"

# setup docker machine
#if command -v docker-machine > /dev/null && [ "$(docker-machine status)" = "Running" ]; then
#	eval $(docker-machine env)
#fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -f ~/.private-tokens.sh ]; then
	. ~/.private-tokens.sh
fi

if [ -d "$HOME/.cargo/bin" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi
if [ -d "$HOME/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src" ]; then
	export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
fi

if [ -d "$HOME/Qt/5.6/gcc_64" ]; then
	export PKG_CONFIG_PATH="$HOME/Qt/5.6/gcc_64/lib/pkgconfig"
	export CMAKE_PREFIX_PATH="$HOME/Qt/5.6/gcc_64"
fi


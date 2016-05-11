source /usr/share/zsh-antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme jreese

# Tell antigen that you're done.
antigen apply

export PATH="/usr/local/bin:$HOME/.node/bin:$PATH:$HOME/.config/.tools"


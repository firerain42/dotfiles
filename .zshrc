export ZSH=~/.zsh

# Load and run compinit
autoload -U compinit
compinit -i

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load additional plugins
source $ZSH/plugins/zsh-256color/zsh-256color.plugin.zsh

# Load autojump
if hash autojump 2> /dev/null; then
    source /usr/share/autojump/autojump.zsh
fi

# Setup variables
export EDITOR=vim
export PATH="$PATH:$HOME/.local/bin/"
if hash rustc 2> /dev/null; then
    export RUST_SRC_PATH=$(rustup which rustc | xargs dirname)/../lib/rustlib/src/rust/src/
fi

# Handle ssh-keys
if hash keychain 2> /dev/null; then
    eval $(keychain --eval -Q --quiet --noask)
fi

# stack completion
if hash stack 2> /dev/null; then
    autoload -U +X bashcompinit && bashcompinit
    eval "$(stack --bash-completion-script stack)"
fi

export ZSH=~/.zsh

# Load and run compinit
autoload -U compinit
compinit -i

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load additional plugins
source $ZSH/plugins/zsh-256color/zsh-256color.plugin.zsh

# Load autojump
source /usr/share/autojump/autojump.zsh &> /dev/null

# Setup variables
export EDITOR=vim
export PATH="$PATH:$HOME/.local/bin/"
export RUST_SRC_PATH=$(rustup which rustc | xargs dirname)/../lib/rustlib/src/rust/src/

# Handle ssh-keys
eval $(keychain --eval -Q --quiet --noask)

# stack completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"

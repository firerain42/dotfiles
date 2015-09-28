export ZSH=~/.zsh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load additional plugins
source $ZSH/plugins/zsh-256color/zsh-256color.plugin.zsh

# Load and run compinit
autoload -U compinit
compinit -i

# Load autojump
#source /usr/share/autojump/autojump.zsh &> /dev/null

# Setup variables
export EDITOR=vim
#export PATH=$PATH:$HOME/.bin/

# Handle ssh-keys
#eval $(keychain --eval -Q --quiet --noask)

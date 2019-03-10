export ZSH=~/.zsh

# Load and run compinit
autoload -U compinit
compinit -i

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load additional plugins
source $ZSH/plugins/zsh-256color/zsh-256color.plugin.zsh

# Setup variables
export EDITOR=vim
export PATH="$PATH:$HOME/.local/bin/"

# Handle ssh-keys
if type keychain &> /dev/null; then
    eval $(keychain --eval -Q --quiet --noask)
fi

# stack completion
if type stack &> /dev/null; then
    autoload -U +X bashcompinit && bashcompinit
    eval "$(stack --bash-completion-script stack)"
fi

# Add anaconda (de)activate
if [ -f ~/.local/share/anaconda3/bin/activate ]; then
    function conda_activate {
        source ~/.local/share/anaconda3/bin/activate #1
    }

    function conda_deactivate {
        source ~/.local/share/anaconda3/bin/deactivate
    }
fi

# Add ranger shortcut
if type ranger &> /dev/null; then
    function rg {
        if [ -z "$RANGER_LEVEL" ]; then
            tempfile="$(mktemp)"
            /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
            test -f "$tempfile" &&
            if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
                cd -- "$(cat "$tempfile")"
            fi
            rm -f -- "$tempfile"
        else
            exit
        fi
    }
else
    echo no ranger
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$PATH:$HOME/.cargo/bin/"
fi
if type rustc &> /dev/null; then
    export RUST_SRC_PATH=$(rustup which rustc | xargs dirname)/../lib/rustlib/src/rust/src/
fi

# fzf
if type fzf &> /dev/null; then
    fd() {
      local dir
      dir=$(find ${1:-.} -path '*/\.*' -prune \
                      -o -type d -print 2> /dev/null | fzf +m) &&
      cd "$dir"
    }
fi

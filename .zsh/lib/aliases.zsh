alias ll='ls -lh'
alias la='ls -lah'
alias ...='cd ../..'
alias -g no='2> /dev/null > /dev/null'
alias open="xdg-open no"
alias vim="nocorrect nvim"
alias tree="nocorrect tree -C"
alias g="tig status"

if type stack &> /dev/null; then
    alias ghci="stack ghci --package classy-prelude"
fi

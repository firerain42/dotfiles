# autoload -U add-zsh-hook
autoload -Uz vcs_info


setopt prompt_subst
autoload -U promptinit
promptinit

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "%F{red}*%F{green}"
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' actionformats ' (%F{green}%b%c%u|%F{red}%a%%f)'
zstyle ':vcs_info:*' formats       ' (%F{green}%b%c%u%f)'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# Disable in /media and /mnt where the filesystems might be slow
zstyle ':vcs_info:*' disable-patterns "/(media|mnt)/*"

# Disable if $ZSH_N0_VCS is set
precmd () {
    if [ -z "$ZSH_N0_VCS" ]; then
        vcs_info
    else
        vcs_info_msg_0_=''
    fi
}
PS1='%{$fg_bold[white]%}[%(!.%{$fg_bold[red]%}%n.%{$fg_bold[blue]%}%n)%{$fg_bold[white]%}@%m %{$fg_bold[cyan]%}%~%{$reset_color%}${vcs_info_msg_0_}%(?.. %{$fg_bold[red]%}(%?%)%{$fg_bold[white]%})%{$fg_bold[white]%}]%{$reset_color%} '

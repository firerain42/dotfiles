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

precmd () { vcs_info }
PS1='%{$fg_bold[white]%}[%(!.%{$fg_bold[red]%}.%{$fg_bold[blue]%}%n@)%{$fg_bold[white]%}%m %{$fg_bold[cyan]%}%~%{$reset_color%}${vcs_info_msg_0_}%{$fg_bold[white]%}]%{$reset_color%} '

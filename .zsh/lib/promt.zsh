# autoload -U add-zsh-hook
autoload -Uz vcs_info

# # enable VCS systems you use
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*:prompt:*' check-for-changes true

setopt prompt_subst
autoload -U promptinit
promptinit


# Look at http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
# for mor options
zstyle ':vcs_info:*' use-prompt-escapes true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "%{$fg_no_bold[red]%}*%{$fg_no_bold[green]%}"   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr "+"  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '(%b%|%a%c%u%)'
zstyle ':vcs_info:*' formats ' (%b%c%u)'


zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }

PROMPT='%{$fg_bold[white]%}[%(!.%{$fg_bold[red]%}.%{$fg_bold[blue]%}%n@)%{$fg_bold[white]%}%m %{$fg_bold[cyan]%}%~%{$fg_no_bold[green]%}${vcs_info_msg_0_}%{$fg_bold[white]%}]%{$reset_color%} '

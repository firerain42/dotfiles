#!/bin/sh

if [ "$#" -ne 1 ]
then
    dotfiles=$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))
else
    dotfiles=$1
fi

cd $dotfiles
git submodule init
git submodule update


mkdir -p $HOME/.config

# zsh
ln -si $dotfiles/zsh/zsh $HOME/.zsh
ln -si $dotfiles/zsh/zshrc $HOME/.zshrc
ln -si $dotfiles/zsh/zlogin $HOME/.zlogin


# vim
ln -si $dotfiles/vim/vim $HOME/.vim
ln -si $dotfiles/vim/vimrc $HOME/.vimrc
mkdir -p $HOME/.vimbackup

# neovim
if hash nvim 2> /dev/null; then
    ln -si $HOME/.vim $HOME/.config/nvim/
    ln -si $HOME/.vimrc $HOME/.config/nvim/init.vim
fi

# tmux
ln -si $dotfiles/tmux/tmux.conf $HOME/.tmux.conf

# lf
ln -si $dotfiles/lf $HOME/.config/lf


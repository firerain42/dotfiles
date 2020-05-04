#!/usr/bin/env bash

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
ln -sfT $dotfiles/zsh/zsh $HOME/.zsh
ln -sfT $dotfiles/zsh/zshrc $HOME/.zshrc
ln -sfT $dotfiles/zsh/zshenv $HOME/.zshenv


# vim
ln -sfT $dotfiles/vim/vim $HOME/.vim
ln -sfT $dotfiles/vim/vimrc $HOME/.vimrc
mkdir -p $HOME/.vimbackup

# neovim
if hash nvim 2> /dev/null; then
    ln -sfT $HOME/.vim $HOME/.config/nvim
    ln -sfT $HOME/.vimrc $HOME/.config/nvim/init.vim
fi

# tmux
ln -sfT $dotfiles/tmux/tmux.conf $HOME/.tmux.conf

# lf
ln -sfT $dotfiles/lf $HOME/.config/lf


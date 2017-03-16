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

ln -s $dotfiles/.vim $HOME/.vim
ln -s $dotfiles/.vimrc $HOME/.vimrc
ln -s $dotfiles/.zsh $HOME/.zsh
ln -s $dotfiles/.zshrc $HOME/.zshrc
mkdir $HOME/.vimbackup

# NeoVim Init
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim


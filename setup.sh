#!/usr/bin/bash

sudo apt-get install vim tmux
git clone https://github.com/VundleVim/Bundle.vim.git ~/.vim/bundle/Vundle.vim
sudo ln -s ~/dotfiles/Scripts/ds /usr/local/bin/open
sudo chmod +x ~/dotfiles/Scripts/ds
sudo ln -s ~/dotfiles/Scripts/remove_output /usr/local/bin/remove_output
sudo chmod +x ~/dotfiles/Scripts/remove_output.py

mv ~/.vimrc ~/vimrc-backup
echo "Created ~/vimrc-backup"
ln -s ~/dotfiles/vimrc ~/.vimrc

mv ~/.bashrc ~/bashrc-backup
echo "Created ~/bashrc-backup"
ln -s ~/dotfiles/bashrc ~/.bashrc

mv ~/.tmux.conf ~/tmux.conf-backup
echo "Created ~/tmux.conf-backup"
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

mv ~/.Xmodmap ~/Xmodmap-backup
echo "Created ~/Xmodmap-backup"
ln -s ~/dotfiles/Xmodmap ~/.Xmodmap


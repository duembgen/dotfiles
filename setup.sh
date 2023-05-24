#!/usr/bin/bash

# setup vim and tmux
sudo apt-get install vim tmux
git clone git@github.com:VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim

# make useful scripts available system-wide
for filename in "open"  "remove_output"  "convert_ln"
do
  sudo chmod +x ~/dotfiles/Scripts/$filename
  sudo ln -s ~/dotfiles/Scripts/$filename /usr/local/bin/$filename
  if [ $? -eq 0 ]; then
    echo "Created /usr/local/bin/$filename"
  fi
done

# create symlinks for dotfiles
for filename in "vimrc"  "bashrc"  "tmux.conf" "Xmodmap"
do
  if [[ -L ~/.$filename ]]; then
    echo "$filename already a link." 
  else
    mv ~/.$filename ~/$filename-backup
    echo "Created ~/$filename-backup"
    ln -s ~/dotfiles/$filename ~/.$filename
  fi
done

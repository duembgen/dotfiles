#!/usr/bin/bash

# setup vim and tmux
sudo apt-get install vim tmux
if test -d $HOME/.vim/bundle/Vundle.vim; then
    echo "$HOME/.vim/bundle/Vundle.vim already exists." 
else
  git clone git@github.com:VundleVim/Vundle.vim $HOME/.vim/bundle/Vundle.vim
fi

# make useful scripts available system-wide
script_dir="$HOME/dotfiles/Scripts"
for fullname in "$script_dir"/*
do
  filename=$(basename ${fullname})
  echo "Treating $(basename ${filename})"
  sudo chmod +x "$script_dir/$filename"
  sudo ln -s "$script_dir/$filename" "/usr/local/bin/$filename"
  if [ $? -eq 0 ]; then
    echo "Created /usr/local/bin/$filename"
  fi
done

# create symlinks for dotfiles
for filename in "vimrc"  "bashrc"  "tmux.conf" "Xmodmap"
do
  if [[ -L $HOME/.$filename ]]; then
    echo "$filename already a link." 
  else
    mv $HOME/.$filename $HOME/$filename-backup
    echo "Created $HOME/$filename-backup"
    ln -s $HOME/dotfiles/$filename $HOME/.$filename
  fi
done

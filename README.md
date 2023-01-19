# dotfiles
 
Personal dotfiles and other configuration files. 


## Python setup

```
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
sudo apt install python3-pip
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
```

## Other Setup

For first time configuration, run the `setup.sh` bash script.

To install vim plugins, run vim and then `:PluginInstall`.

For YouCompleteMe:
```
cd .vim/bundle/YouCompleteMe
./install.py --all
```

For virtual environments: 
```
pip install virtualenvwrapper
```

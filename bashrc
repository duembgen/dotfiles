# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# touchpad settings

# xinput --set-prop bcm5974 "Synaptics Off" 0 
# xinput --set-prop bcm5974 "Synaptics Noise Cancellation" 30 30
# xinput --set-prop bcm5974 "Synaptics Finger" 10 20 25 # syntax: low high press
# xinput --set-prop bcm5974 "Synaptics Scrolling Distance" -243 243
# xinput --set-prop bcm5974 "Synaptics Tap Action" 1 1 1 1 1 3 0
# xinput --set-prop bcm5974 "Synaptics Click Action" 1 3 0

# disable non-breaking spaces
setxkbmap -option "nbsp:none"

# ROS stuff
# source /opt/ros/indigo/setup.bash

# extract file.tar.gz
alias targz_extract='tar -xzvf'

# editor
export EDITOR=vim

# Command to generate standalone EFI file and copy to apple bootfolder
mkgrubcfg() {
    echo "Backing up previous boot.efi file"
    cp /shared/bootfiles/boot.efi /shared/bootfiles/boot.efi.old
    echo "Generating new standalone boot.efi file"
    sudo grub-mkconfig -o /boot/grub/grub.cfg && \
    sudo grub-mkstandalone -o /shared/bootfiles/boot.efi -d /usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz /boot/grub/grub.cfg && \
    echo "Mounting Ubuntu boot partition and copying boot.efi"
    sudo mount UUID=d67706b4-1b37-3d25-ad56-a925021e081c /mnt/apple-boot && \
    sudo cp -v /shared/bootfiles/boot.efi /mnt/apple-boot/System/Library/CoreServices/ &&
    echo "Unmount Ubuntu boot partition"
    sudo umount /mnt/apple-boot
}

# check if xmodmap has already been run, and if not run it
x=$(xmodmap -pke | grep Caps_Lock | grep F13)
if [[ -z "$x" ]]; 
then 
    xmodmap ~/.Xmodmap
fi

export LPATH=/usr/lib/nvidia-current:$LPATH
export LIBRARY_PATH=/usr/lib/nvidia-current:$LIBRARY_PATH
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# add --si to show files in kB/MB/GB (1000 increments) rather than default kiB, MiB, GiB (1024 increments)
alias show_usage="du -sh * | sort -h"
alias find_file="find ./ -type f -name "
alias decrease_brightness="xrandr --output DP-1 --brightness 0.5"
# fan options. 
alias fan_off="echo level 0 | sudo tee /proc/acpi/ibm/fan"
alias fan_on="echo level 2 | sudo tee /proc/acpi/ibm/fan"
alias fan_auto="echo level auto | sudo tee /proc/acpi/ibm/fan"


# For making OpenGL work
export Eigen_INCLUDE_DIR=/home/kiki/Libs/Eigen
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# export PATH=/home/kiki/miniconda3/bin${PATH:+:${PATH}}

# Jekyll stuff
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

export LD_LIBRARY_PATH=/usr/lib/python-2.7:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/python3:$LD_LIBRARY_PATH
#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python35.zip:/usr/local/lib/python3.5:/usr/local/lib/python3.5/plat-linux:/usr/local/lib/python3.5/lib-dynload:$HOME/.local/lib/python3.5/site-packages:/usr/local/lib/python3.5/site-packages:/usr/lib/python3/dist-packages/


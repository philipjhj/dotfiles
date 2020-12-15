# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# PATH
export PATH="/usr/local/texlive/2016/bin/x86_64-linux:$PATH"
export PATH="/media/data/programs/MATLAB/matlab2017b/bin/:$PATH"

## Scripts
#export PATH="~/bin:$PATH"
for d in ~/scripts/*/bin; do PATH="$PATH:$d"; done
PATH="$PATH:~/scripts/utilities"
PATH="$PATH:~/scripts/bash/bin/i3"

# Malmo Project (Microsft research)
export MALMO_XSD_PATH=/media/data/Dropbox/Studie/PhD/code/malmoChallenge/MalmoProject/Schemas
export PYTHONPATH=$PYTHONPATH:/media/data/Dropbox/Studie/PhD/code/malmoChallenge/MalmoProject/malmo-challenge/ai_challenge/pig_chase

# ALIAS DEFINITIONS
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias scriptsMenu='. scriptsMenu'
alias reloadBash='. 00_reloadBash'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias f='nautilus .'

#alias vim='vim --servername vim'



alias gbar='ssh phav@login.gbar.dtu.dk'
alias gbarx='ssh -X phav@login.gbar.dtu.dk'

alias mnt_gbar_work1='sshfs phav@transfer.gbar.dtu.dk:/work1/phav/ gbar_work1'
alias mnt_gbar_root='sshfs phav@transfer.gbar.dtu.dk: gbar_root'
alias mnt_dabai='sshfs -o reconnect -o IdentityFile=~/.ssh/id_rsa phav@thinlinc.compute.dtu.dk:/dtu-compute/dabai dabai_data'

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
#alias ls='ls --hide="*~" --color=auto'
alias ll='ls -alFtr'
alias la='ls -A'
alias l='ls -CF'
#alias ls='ls -1 --color'

# FUNCTIONS

# enable color support of ls and also add handy aliases
lsf () {
    path=${1:-.};
    #echo $path;
    find $path -maxdepth 1 -type f -print0 | xargs -0r ls;
}

gpustat () { 
    if [ -z ${1+x} ]; then
        parallel-ssh --user=phav --hosts=$HOME/gpu_hosts -P "PYTHONPATH=:/usr/local/lib/python2.7/site-packages gpustat";
    else
        parallel-ssh --user=phav --host="$1.compute.dtu.dk" -P "PYTHONPATH=:/usr/local/lib/python2.7/site-packages gpustat";
    fi
}

gpucluster () {
    ssh phav@$1.compute.dtu.dk
}

wifi () {

        if [ -n $1 ]; then 
                if [ "$1" == "list" ]; then 
                   nmcli d wifi list --rescan yes
                 elif [ "$1" == "connect" ]; then
                   # Dynamic selection menu from 
                   # (https://stackoverflow.com/questions/27389089/dynamic-option-selection-in-bash)
                   choices=$(wifi list | awk -F '\t| {2,}' '{print $2}' | sort -u)
                   OLDIFS=IFS
                   IFS=$'\n'

                   #echo "$choices"
                   choices=($(echo "$choices"))
                   #echo ${choices[@]}

                   PS3="Choose wifi to connect to:"
                   select selected in "${choices[@]}"; do
                           for item in "${choices[@]}"; do
                               if [[ $item == $selected ]]; then
                                 break 2
                               fi
                           done
                   done
                   echo "Trying to connect to $selected"                    
                   nmcli -a d wifi connect $selected 

                   IFS=OLDIFS
                else
                    echo $1" is an unknown command"
                 fi 
          fi
}

print_msg () {
    #echo $(date '+%H:%M:%S %d-%m-%Y')':'$1': '$2
    print_msg_aligned "$1" "$2"
}
print_msg_aligned () {
        info_string=$(date '+%H:%M:%S %d-%m-%Y')
        len_info_string=${#info_string}
        len_first_arg=${#1}

        terminal_width=$(tput cols)
        padding_width=$((len_info_string+len_first_arg+3))
        msg_width=$((terminal_width-padding_width))

        padding=$(printf " %.0s" $(seq 1 $padding_width))
        padded_msg="2,\$s/^/"$padding"/g"

        # https://stackoverflow.com/questions/16583320/format-multiline-command-output-in-bash-using-printf

        printf '%s:%-10s %s\n' "$info_string" "$1:" "$(echo $2 | fold -w$msg_width | sed "$padded_msg")"
}

reset_sound () {
        systemctl --user stop pulseaudio.socket 
        systemctl --user stop pulseaudio.service
        sudo alsa force-reload
        systemctl --user start pulseaudio.socket
        systemctl --user start pulseaudio.service
}

# encrypting setup from https://unix.stackexchange.com/questions/28603/simplest-way-to-password-protect-a-directory-and-its-contents-without-having-to

mount_encrypted_dir () {
        dir=${1:-logbooks_encrypted}
        encfs ~/.$dir ~/$dir
}

unmount_encrypted_dir () {
        dir=${1:-logbooks_encrypted}
        fusermount -u ~/$dir
}
# HISTORY

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# OTHER

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

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
#force_color_prompt=yes

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


export PROMPT_COMMAND='PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")'
export PS1='\u ${PS1X} $ '

# update and read history on all commands
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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


# Git completion (https://stackoverflow.com/questions/12399002/how-to-configure-git-bash-command-line-completion)
source /usr/share/bash-completion/completions/git

# Vim configuration
# Stop ctrl+s from freezing terminal
stty -ixon

# Set CAPSLOCK to CTRL
#setxkbmap -option caps:ctrl_modifier


alias o="xdg-open" # o stands for open

# Colors
eval `dircolors ~/.dir_colors/dircolors.256dark`

# Change Gnome-Terminal Profile
function chp(){
      xdotool key Shift+F10 r $1
}

alias dark='chp 2'
alias light='chp 3'




# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/media/programs/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/media/programs/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/media/programs/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/media/programs/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate py37


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

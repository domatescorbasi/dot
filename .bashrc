#!/bin/bash

export TERM=xterm-color
export EDITOR=vim

## this variable is used for case insensitivity thing.
iatest=$(expr index "$-" i)

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_functions, instead of adding them here directly.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines in the history
# Don't add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Causes bash to append to history instead of overwriting it
# so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# Expand the history size
export HISTFILESIZE=1000000
export HISTSIZE=50000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

# if [ -f ~/.git-completion.bash ]; then
# 	source ~/.git-completion.bash
# fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# Allow ctrl-S for history navigation (with ctrl-R) ;
# Adds backward traversing to command search in the bash history
stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

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

PS1='\[\033[1;36m\]┌─[ \[\033[38;5;10m\]\u\[\033[38;5;36m\]@\[\033[38;5;9m\]\h\[\033[1;36m\] ]\[\033[1;36m\] [\[\033[1;33m\]\t\[\033[1;36m\]\[\033[1;36m\]]\n└─\[\033[1;36m\][ \[\033[38;5;137m\]\w\[\033[1;36m\] ]\[\033[38;5;230m\] \[\033[48;5;1m\]$(chkec)\[\e[m\] \[\033[1;36m\]\$\[$(tput sgr0)\] '


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


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

# Makes man pages colorful
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Complete commands after sudo with tab.
complete -cf sudo

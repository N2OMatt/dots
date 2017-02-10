## COWTODO: Put this stuff on the right place...

if [ -n "$TERM" ]; then
    bind -x '"\C-l":clear; $PROMPT_COMMAND' > /dev/null 2>&1;
fi;

################################################################################
## Aliases                                                                    ##
################################################################################
## clear
alias cl="clear";

## ls
alias ls="ls -Fh --color=auto" #Colorize | Classify | Human Sizes.
alias la="ls -a  --color=auto" #Print hidden.
alias ll="ls -l  --color=auto" #Long list.
## mv
alias mv="mv -vi" #Make mv verbose and iterative.
## cp
alias cp="cp -v" #Make cp verbose.
## df
alias df="df -H" #Human readable.
## du
alias du="du -ch" #Grand Total | Human readable.
## clang / g++ ##
alias g++="g++ -std=c++11" #C++11 by default.
alias clang="clang++ -std=c++11"

## URL ##
alias url-encode='python -c "import sys, urllib as ul; \
print ul.quote_plus(\" \".join(sys.argv[1:]))"'

alias abs-path='python -c "import os.path; \
                           import sys; \
                           print os.path.abspath(os.path.expanduser(sys.argv[1]))"'



## In cases that realpath is missing.
if [ -n "$(whereis realpath | cut -d":" -f2 | cut -d" " -f2)" ]; then
    alias realpath="readlink -f"
fi;


## Make the bash completion works.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

## Python Scrap ##
py-scrap()
{
    subl $(mktemp)".py";
}

##
alias get-sum="paste -sd+ - | bc"

source "$(realpath ~/.cygwin_dots/files.sh)"
source "$(realpath ~/.cygwin_dots/git.sh)"
source "$(realpath ~/.cygwin_dots/ps1.sh)"

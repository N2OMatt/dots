## COWTODO: Put this stuff on the right place...
if [ -n "$TERM" ]; then
    bind -x '"\C-l":clear; $PROMPT_COMMAND' > /dev/null 2>&1;
fi;



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

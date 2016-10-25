## COWTODO: Put this stuff on the right place...

if [ -n "$TERM" ]; then
    bind -x '"\C-l":clear; $PROMPT_COMMAND' > /dev/null 2>&1;
fi;

## COWTODO: This is probably a not reliable way to do this..
alias keep="chromium-browser --ppapi-flash-path=/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so --ppapi-flash-version=21.0.0.216 --enable-pinch --profile-directory=Default --app-id=hmjkmjkepdijhoojdojkdfohbdgmmhki 2>&1 1> /dev/null "

################################################################################
## Aliases                                                                    ##
################################################################################
## clear
alias cl="clear";
## rm
if [ -n "$(whereis safe-rm | cut -d":" -f2 | cut -d" " -f2)" ]; then
    alias rm="safe-rm";
fi;


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
## Editors
alias gedit="subl" #Make easy to copy scripts from net.
alias emacs="emacs24 -nw" #Prefer the terminal version.
alias emacs-gui="emacs24-x"
## clang / g++ ##
alias g++="g++ -std=c++11" #C++11 by default.
alias clang="clang++ -std=c++11"

## Jekyll ##
alias jekyll-serve="jekyll clean && jekyll serve --watch --future"

## This is a must ##
alias lock-screen='gnome-screensaver-command --lock'

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


source "$(realpath ~/.linux_dots/AmazingCow.sh)"
source "$(realpath ~/.linux_dots/apt.sh)"
source "$(realpath ~/.linux_dots/browser.sh)"
source "$(realpath ~/.linux_dots/cocos.sh)"
source "$(realpath ~/.linux_dots/connections.sh)"
source "$(realpath ~/.linux_dots/files.sh)"
source "$(realpath ~/.linux_dots/git.sh)"
source "$(realpath ~/.linux_dots/gosh.sh)"
source "$(realpath ~/.linux_dots/manual.sh)"
source "$(realpath ~/.linux_dots/markdown.sh)"
source "$(realpath ~/.linux_dots/ps1.sh)"
source "$(realpath ~/.linux_dots/youtube-dl.sh)"

##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : hacks.sh                                                      ##
##  Project   : dots                                                          ##
##  Date      : Feb 24, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2017, 2018                                          ##
##                                                                            ##
##  Description :                                                             ##
##    Stuff that I don't know where to place.                                 ##
##---------------------------------------------------------------------------~##

##----------------------------------------------------------------------------##
## URL                                                                        ##
##----------------------------------------------------------------------------##
alias url-encode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(\" \".join(sys.argv[1:]))"'

alias abs-path='python -c "import os.path; \
                           import sys; \
                           print os.path.abspath(os.path.expanduser(sys.argv[1]))"'


##----------------------------------------------------------------------------##
## Python Scrap                                                               ##
##----------------------------------------------------------------------------##
py-scrap()
{
    subl $(mktemp)".py";
}


##----------------------------------------------------------------------------##
## Other                                                                      ##
##----------------------------------------------------------------------------##
function my-grip()
{
    grip --user=n2omatt --pass="$1";
}


## In cases that realpath is missing.
if [ -n "$(whereis realpath | cut -d":" -f2 | cut -d" " -f2)" ]; then
    alias realpath="readlink -f"
fi;


## Make the bash completion works.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

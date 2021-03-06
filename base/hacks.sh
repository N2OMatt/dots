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
## ????                                                                       ##
##----------------------------------------------------------------------------##
## In cases that realpath is missing.
if [ -n "$(whereis realpath | cut -d":" -f2 | cut -d" " -f2)" ]; then
    alias realpath="readlink -f"
fi;

## Make the bash completion works.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


##----------------------------------------------------------------------------##
## Other                                                                      ##
##----------------------------------------------------------------------------##
##------------------------------------------------------------------------------
## Provides a convenient way to init grip with the user and password.
function my-grip()
{
    if [ -n "$(whereis grip | cut -d":" -f2 | cut -d" " -f2)" ]; then
        grip --user=n2omatt --pass="$1";
    else
        echo "grip isn't installed.";
    fi;
}

##------------------------------------------------------------------------------
## Provides a convenient to initialize the lhcrc file.
my-lhc()
{
    COMPANY="AmazingCow";
    IGNORE="false";

    ##--------------------------------------------------------------------------
    ## Parse the options.
    for OPT in "$@"; do
        if [ "$OPT" == "--ignore" ]; then
            IGNORE="true";
        else
            COMPANY="$OPT"
        fi;
    done

    ##--------------------------------------------------------------------------
    ## Add the info to lhcrc.
    echo "author  : n2omatt <n2omatt@amazingcow.com>" >  lhcrc;
    echo "company : $COMPANY"                         >> lhcrc;

    ##--------------------------------------------------------------------------
    ## Log the info.
    echo "[lhcrc contents]";
    cat lhcrc;

    ##--------------------------------------------------------------------------
    ## Add to gitignore if needed.
    if [ "$IGNORE" == "true" ]; then
        ## .gitignore doesn't exists yet...
        if [ ! -e ".gitignore" ]; then
            echo "lhcrc" > .gitignore;
        ## .gitignore exits - So check if we don't already had an entry.
        else
            grep "lhcrcd" .gitignore > /dev/null;
            test $? == 0 || echo -e "\nlhcrc\n" >> .gitignore
        fi;
    fi;
}

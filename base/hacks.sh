################################################################################
## File    : hacks.sh                                                         ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Stuff that I don't know where to place.                                    ##
################################################################################

################################################################################
## URL                                                                        ##
################################################################################
alias url-encode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(\" \".join(sys.argv[1:]))"'

alias abs-path='python -c "import os.path; \
                           import sys; \
                           print os.path.abspath(os.path.expanduser(sys.argv[1]))"'


################################################################################
## Python Scrap                                                               ##
################################################################################
py-scrap()
{
    subl $(mktemp)".py";
}


################################################################################
## Other                                                                      ##
################################################################################
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


repeat()
{
    target=0;
    count=0;
    cmd="";

    check=$(echo "$1" | grep -E ^\-?[0-9]+$);
    if [ -z $check ]; then
        target=$2;
        cmd="$1";
    else
        target=$1;
        cmd="$2";
    fi;

    while true; do
        $cmd;

        echo "$count - $target";
        count=$(( count + 1 ));

        if [ $count == $target ]; then
            break;
        fi;
    done;
}

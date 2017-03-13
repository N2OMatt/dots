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

## In cases that realpath is missing.
if [ -n "$(whereis realpath | cut -d":" -f2 | cut -d" " -f2)" ]; then
    alias realpath="readlink -f"
fi;


## Make the bash completion works.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

################################################################################
## File    : coreutils.sh                                                     ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Some aliases for GNU coreutils programs.                                   ##
################################################################################


##------------------------------------------------------------------------------
## ls
alias ls="ls -Fh --color=auto" ## Colorize | Classify | Human Sizes.
alias la="ls -a  --color=auto" ## Print hidden.
alias ll="ls -l  --color=auto" ## Long list.

##------------------------------------------------------------------------------
## mv
alias mv="mv -vi" ## Make mv verbose and iterative.

##------------------------------------------------------------------------------
## cp
alias cp="cp -v" ## Make cp verbose.

##------------------------------------------------------------------------------
## df
alias df="df -H" ## Human readable.

##------------------------------------------------------------------------------
## du
alias du="du -ch" ## Grand Total | Human readable.

##------------------------------------------------------------------------------
## clear
alias cl="clear";

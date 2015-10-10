
################################################################################
## Aliases                                                                    ##
################################################################################
## ls 
#In OSX and Linux the ls are different.
alias ls="ls -GFh" #Colorize | Classify | human sizes.
alias la="ls -a"   #Print hidden.
alias ll="ls -l"   #Long list.

## mv 
alias mv="mv -vi" #Make mv verbose and iteractive.

## cp
alias cp="cp -v" #Make cp verbose.

## clang/g++
alias g++="g++ -std=c++11" #C++11 by defaut.

################################################################################
## Prompt                                                                     ##
################################################################################
#Makes my prompt be: 
#   Amanda:Directory:n2omatt $
#Where Amanda is random colored - Without the black.
PS1="\[$(tput setaf $(( 1 + RANDOM % 7)) )\]\h\[$(tput sgr 0)\]:\W \u\$ "


################################################################################
## Manual                                                                     ##
################################################################################
## Saves a manual page to the current directory.
## Very same way of call man...
## saveman [Section] [Page.]
saveman-txt() {
    man $1 $2 | col -b > $2$1"_osx.txt"
}
saveman-pdf() {
    man -t $1 $2 | pstopdf -i -o $2$1"_osx.pdf"
}
saveman() {
    saveman-txt $1 $2
    saveman-pdf $1 $2
}

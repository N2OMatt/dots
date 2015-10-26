
################################################################################
## Aliases                                                                    ##
################################################################################
## ls
#In OSX and Linux the ls are different.
alias ls="ls -GFh" #Colorize | Classify | human sizes.
alias la="ls -a"   #Print hidden.
alias ll="ls -l"   #Long list.
## mv
alias mv="mv -vi" #Make mv verbose and iterative.
## cp
alias cp="cp -v" #Make cp verbose.
## df
alias df="df -H" #Human readable.
## du
alias du="du -ch" #Grand Total | Human readable.

## clang/g++
alias g++="g++ -std=c++11" #C++11 by default.

## Google Chrome ##
alias chrome="open -a \"Google Chrome\"";

## This is a must ##
alias lock-screen='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'


################################################################################
## Prompt                                                                     ##
################################################################################
#Makes my prompt be:
#   Amanda:Directory:n2omatt $
#Where Amanda is random colored - Without the black.
PS1="\[$(tput setaf $(( 1 + RANDOM % 7)) )\]\h\[$(tput sgr 0)\]:\W \u\$ "


################################################################################
## Functions                                                                  ##
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

## Make a google search and opens the result on Chrome.
google-search()
{
    #COWTODO: We should encode the $1 - C++ -> C%2B%2B
    chrome "https://www.google.com/search?q=$1";
}

## Get/Set the dock size.
get-dock-size()
{
    defaults read com.apple.dock tilesize;
}
set-dock-size()
{
    #COWTODO: Sanity checks...
    defaults write com.apple.dock tilesize -int $1
    killall Dock
}

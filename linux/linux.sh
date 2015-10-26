
################################################################################
## Aliases                                                                    ##
################################################################################
## ls
#In OSX and Linux the ls are different.
alias ls="ls -Fh --color=auto" #Colorize | Classify | human sizes.
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

## Google Chrome ##
alias chrome="chromium-browser";

## This is a must ##
alias lock-screen='gnome-screensaver-command --lock'


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
    man $1 $2 | col -b > $2$1"_linux.txt"
}
saveman-pdf() {
	#Redirect stderr 			Quiet and from stdin.
    man -t $1 $2 2> /dev/null | ps2pdf -dQUIET - $2$1"_linux.pdf"
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


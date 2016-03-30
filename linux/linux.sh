
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
## Editors
alias gedit="subl" #Make easy to copy scripts from net.


## apt stuff ##
alias apt-update-upgrade="sudo apt-get update -y && sudo apt-get upgrade -y"

## clang/g++ ##
alias g++="g++ -std=c++11" #C++11 by default.
alias clang="clang++ -std=c++11"

## Google Chrome ##
alias chrome="chromium-browser";

## Jekyll ##
alias jekyll-serve="jekyll clean && jekyll serve --watch --future"

## Gitcheck ##
alias gitcheck="python ~/.local/lib/python2.7/site-packages/gitcheck/gitcheck.py"

## This is a must ##
alias lock-screen='gnome-screensaver-command --lock'

## URL ##
alias url-encode='python -c "import sys, urllib as ul; \
print ul.quote_plus(\" \".join(sys.argv[1:]))"'


################################################################################
## Prompt                                                                     ##
################################################################################
#Makes my prompt be:
#   Amanda:Directory:n2omatt $
#Where Amanda is random colored - Without the black.
PS1="[\[$(tput setaf $(( 1 + RANDOM % 7)) )\]\h\[$(tput sgr 0)\]:\W] \u\$ "


################################################################################
## Functions                                                                  ##
################################################################################

n2o_private_dir_to_saveman()
{
    local DIR_TO_SAVE_MAN=".";

    if [ -d "/home/n2omatt/Documents/Projects/N2OMatt/manpages" ]; then
        DIR_TO_SAVE_MAN="/home/n2omatt/Documents/Projects/N2OMatt/manpages";
    fi

    echo $DIR_TO_SAVE_MAN;
}

## Saves a manual page to the current directory.
## Very same way of call man...
## saveman [Section] [Page.]
saveman-txt()
{
    #COWTODO: Add a verbose option and make the echo silent by default.

    local OUTPUT_FILENAME=$(n2o_private_dir_to_saveman)"/"$2$1"_linux.txt";
    man $1 $2 | col -b > $OUTPUT_FILENAME;

    echo $OUTPUT_FILENAME;
}
saveman-pdf()
{
    #COWTODO: Add a verbose option and make the echo silent by default.

    local OUTPUT_FILENAME=$(n2o_private_dir_to_saveman)"/"$2$1"_linux.pdf";
    #Redirect stderr            Quiet and from stdin.
    man -t $1 $2 2> /dev/null | ps2pdf -dQUIET - $OUTPUT_FILENAME;

    echo $OUTPUT_FILENAME;
}
saveman()
{
    saveman-txt $1 $2
    saveman-pdf $1 $2
}

## Youtube-dl ##
youtube-dl-auto()
{
    youtube-dl $1 && exit;
}

## apt ##
apt-show()
{
    apt-cache show $1
}

## Make a google search and opens the result on Chrome.
google-search()
{
    #Encode the all function arguments.
    URL=$(url-encode $@)

    #Redirect the error output...
    chrome "https://www.google.com/search?q=$URL" 2> /dev/null;
}

## Open the Filesystem Manager into a given path...
## If no path was given open the current dir.
files()
{
    #This is needed because caja is located in the /usr/bin
    #And it could be not placed in the PATH env var.
    local CAJA=$(which caja);

    #Initialize the destination path to the current dir.
    local PATH=".";

    #Check if the input is comming from a pipe (stdin) or
    #from the arguments...
    if [ -t 0 ]; then
        #User (Myself actually :P) passed a custom path...
        if [ ! -z "$1" ]; then
            PATH=$1;
        fi;
    else
        read PATH;
    fi;

    #Don't write the error messages into the terminal.
    $CAJA 2> /dev/null $PATH
}

## This is a version of Gosh (using gosh actually) that lets us
## change the directory (open new window) in the file manager.
goshf()
{
    RET=`gosh -p $1`
    if [ $? = 0 ]; then
        files $RET;
    else
        echo $RET;
    fi;
}


## Litte hack that enables the bash completes the stuff for goshf too.
## COWTODO: There is another better way to do this???
BASH_COMPLETION_DIR=$(pkg-config --variable=completionsdir bash-completion);
if [ -f $BASH_COMPLETION_DIR/gosh ]; then
    if [ ! -e $BASH_COMPLETION_DIR/goshf ]; then
        sudo cp $BASH_COMPLETION_DIR/gosh $BASH_COMPLETION_DIR/goshf
        sudo echo "complete -F _gosh goshf" >> $BASH_COMPLETION_DIR/goshf
        source $BASH_COMPLETION_DIR/goshf
    fi;
fi;
unset BASH_COMPLETION_DIR

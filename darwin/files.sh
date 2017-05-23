################################################################################
## File    : files.sh                                                         ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Stuff to open the Graphical File Manager from the command line.            ##
################################################################################


################################################################################
## Functions                                                                  ##
################################################################################
#Open the Filesystem Manager into a given path.
#If no path was given open the current dir.
files()
{
    #Initialize the destination path to the current dir.
    local path=".";

    #Check if the input is comming from a pipe (stdin) or
    #from the arguments...
    if [ -t 0 ]; then
        #User (Myself actually :P) passed a custom path...
        if [ ! -z "$1" ]; then
            path=$1;
        fi;
    else
        read path;
    fi;

    #Don't write the error messages into the terminal.
    open 2> /dev/null $path
}

################################################################################
## File    : browser.sh                                                       ##
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
    #This is needed because caja is located in the /usr/bin
    #And it could be not placed in the PATH env var.
    local caja=$(which caja);

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


    #COWTODO: We don't handle the quoted text today.
    #COWTODO: We don't check for path validity.

    #Don't write the error messages into the terminal.
    $caja 2> /dev/null $path
}

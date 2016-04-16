################################################################################
## apt                                                                        ##
## COWTODO: Add description                                                   ##
################################################################################


## Functions ##

#Open the Filesystem Manager into a given path...
#If no path was given open the current dir.
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

##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : files.sh                                                      ##
##  Project   : dots                                                          ##
##  Date      : Jan 02, 2018                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2018                                                ##
##                                                                            ##

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


    #COWTODO: We don't handle the quoted text today.
    #COWTODO: We don't check for path validity.

    #Don't write the error messages into the terminal.
    xdg-open > /dev/null 2>&1   "$path"
}

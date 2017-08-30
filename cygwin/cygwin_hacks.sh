################################################################################
## File    : cygwin_hacks.sh                                                  ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Stuff that I don't know where to place.                                    ##
################################################################################

subl()
{
    SUBL=/cygdrive/c/Program\ Files/Sublime\ Text\ 3/subl.exe;
    "$SUBL" "$(nt_path "$@")";
}

devenv()
{
    ## COWTODO(n2omatt): Implement a way to open VS from terminal.
    echo "Implement..."
}

##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : manual.sh                                                     ##
##  Project   : dots                                                          ##
##  Date      : Feb 25, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2017, 2018                                          ##
##                                                                            ##
##  Description :                                                             ##
##    Functions to save/export manual pages in text and pdf formats.          ##
##---------------------------------------------------------------------------~##

##----------------------------------------------------------------------------##
## Functions                                                                  ##
##----------------------------------------------------------------------------##
openman()
{
    ## Assume that we're passing the full format.
    local SECTION=$1;
    local PAGE=$2;

    ## Since we can pass only the page we need
    ## adjust the vars here.
    if [ -z "$PAGE" ]; then
        PAGE=$SECTION;
        SECTION="";
    fi;

    ## Find the path of manual
    local MAN_PATH=$(man -w $SECTION $PAGE);

    ## Check if we have a valid manual.
    if [ -z "$MAN_PATH" ]; then
        echo "[FATAL] There's no manual for ($PAGE) in section ($SECTION)";
        return;
    fi;

    ## Get the section if it isn't specified.
    local MAN_INFO=$(basename "$MAN_PATH" ".gz");
    REAL_PAGE=$(   echo $MAN_INFO | cut -d"." -f1);
    REAL_SECTION=$(echo $MAN_INFO | cut -d"." -f2);

    ##--------------------------------------------------------------------------
    ## The man pages are separated in:
    ##   1   Executable programs or shell commands
    ##   2   System calls (functions provided by the kernel)
    ##   3   Library calls (functions within program libraries)
    ##   4   Special files (usually found in /dev)
    ##   5   File formats and conventions eg /etc/passwd
    ##   6   Games
    ##   7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7)
    ##   8   System administration commands (usually only for root)
    ##   9   Kernel routines [Non standard]
    ##
    ## We gonna separate our man pages into 2 sections only:
    ##   System - For everything that aren't "callable" from C.
    ##   C      - For everything that are "callable" from C.
    ##
    local OUTPUT_SECTION="";
    case $REAL_SECTION in
        1 | 4 | 5 | 7 | 8 | 9 ) OUTPUT_SECTION="system"; ;;
        2 | 3                 ) OUTPUT_SECTION="C";      ;;
    esac

    ## Where we gonna save the manual.
    local CURR_OS="";
    case $(uname -a | tr "[:upper:]" "[:lower:]") in
        *darwin* ) CURR_OS="osx";   ;;
        *cygwin* ) CURR_OS="cygwin";   ;;
        *linux*  ) CURR_OS="gnu_linux"; ;;
    esac

    local FILENAME="${REAL_PAGE}_${CURR_OS}.pdf";
    local OUTPUT_DIR="$HOME/Documents/Projects/N2OMatt/manpages/$OUTPUT_SECTION";
    local OUTPUT_PATH="$OUTPUT_DIR/$FILENAME";

    echo "Section        : $REAL_SECTION";
    echo "Page           : $REAL_PAGE";
    echo "Man Path       : $MAN_PATH";
    echo "Output Section : $OUTPUT_SECTION";
    echo "Output Path    : $OUTPUT_PATH";

    ## Create the directory if needed.
    mkdir -vp $OUTPUT_DIR;

    # Manual page doesn't exists yet...
    if [ ! -e $OUTPUT_PATH ]; then
        echo "Manual doesn't exists yet - Creating now..."
        ## Redirect stderr          Quiet and from stdin.
        man -t $1 $2 2> /dev/null | ps2pdf -dQUIET - $OUTPUT_PATH;
    fi;

    xdg-open "$OUTPUT_PATH" > /dev/null 2>&1 &
}

openman-sync()
{
    cd "$HOME/Documents/Projects/N2OMatt/manpages/$OUTPUT_SECTION";

    ## Commit everything that we have on local.
    git add .
    git commit -m "[openman-sync] $(date)";

    ## Accept everything from remove.
    git pull --commit --no-edit origin master;

    ## Sync...
    git push origin master;
}

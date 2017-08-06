################################################################################
## File    : manual.sh                                                        ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Functions to save/export manual pages in text and pdf formats.             ##
################################################################################

################################################################################
## Private Functions                                                          ##
################################################################################
n2o_private_dir_to_saveman()
{
    local DIR_TO_SAVE_MAN=".";

    if [ -d "/home/n2omatt/Documents/Projects/N2OMatt/manpages" ]; then
        DIR_TO_SAVE_MAN="/home/n2omatt/Documents/Projects/N2OMatt/manpages";
    fi

    echo $DIR_TO_SAVE_MAN;
}


################################################################################
## Public Functions                                                           ##
################################################################################
#Saves a manual page to the current directory.
#Very same way of call man...
#saveman [Section] [Page.]
saveman-txt()
{
    #COWTODO: Add a verbose option and make the echo silent by default.
    local OUTPUT_FILENAME=$2$1"_linux.txt";
    local OUTPUT_DIRNAME=$(n2o_private_dir_to_saveman);

    local OUTPUT_FULLNAME=$OUTPUT_DIRNAME"/"$OUTPUT_FILENAME;
    local RESULT=$(find $OUTPUT_DIRNAME -iname $OUTPUT_FILENAME);

    if [ -n "$RESULT" ]; then
        echo "$OUTPUT_FILENAME already exists...";
        return 0;
    fi

    man $1 $2 | col -b > $OUTPUT_FULLNAME;
    echo "saved: " $OUTPUT_FULLNAME;
}

saveman-pdf()
{
#COWTODO: Add a verbose option and make the echo silent by default.
    local OUTPUT_FILENAME=$2$1"_linux.pdf";
    local OUTPUT_DIRNAME=$(n2o_private_dir_to_saveman);

    local OUTPUT_FULLNAME=$OUTPUT_DIRNAME"/"$OUTPUT_FILENAME;
    local RESULT=$(find $OUTPUT_DIRNAME -iname $OUTPUT_FILENAME);

    if [ -n "$RESULT" ]; then
        echo "$OUTPUT_FILENAME already exists...";
        return 0;
    fi

    # #Redirect stderr            Quiet and from stdin.
    man -t $1 $2 2> /dev/null | ps2pdf -dQUIET - $OUTPUT_FULLNAME;
    echo "saved: " $OUTPUT_FULLNAME;
}

saveman()
{
    saveman-txt $1 $2
    saveman-pdf $1 $2
}

openman()
{
    local SEARCH_DIR=$(n2o_private_dir_to_saveman);
    local OUTPUT_FILENAME=$2$1"_linux.pdf";

    local FULLPATH=$(find $SEARCH_DIR -iname "$OUTPUT_FILENAME");
    if [ -z "$FULLPATH" ]; then
        saveman $1 $2;
    fi;

    xdg-open $FULLPATH &
}

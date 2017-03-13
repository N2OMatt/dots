#!/bin/bash
################################################################################
## File    : install.sh                                                       ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Installation helper script for dots.                                       ##
################################################################################


################################################################################
## Variables                                                                  ##
################################################################################
BASE_DIR="";
LOCAL_DIR="";
OUTPUT_DIR="";
DOTS_DIR="";
BASE_FILES="";
LOCAL_FILES="";

################################################################################
## Functions                                                                  ##
################################################################################
copy_files() {
    FILES=$1;
    DIR=$2;

    for FILENAME in $FILES; do
        FULLPATH=$DIR/$FILENAME;

        #Sanity checking...
        if [ ! -e $FULLPATH ]; then
            echo "Error: ($FULLPATH) does not exists...";
            exit 1;
        fi;

        #Copy...
        echo "----> Copying ($FULLPATH) to ($OUTPUT_DIR)";
        mkdir -p $OUTPUT_DIR;
        cp $FULLPATH $OUTPUT_DIR;

    done;
}


add_to_main() {
    FILES=$1;

    for FILENAME in $FILES; do
        echo "----> Adding to main.sh: ($FILENAME)";
        echo "source" "$DOTS_DIR/$FILENAME" >> "$OUTPUT_DIR/main.sh";
    done;
}


################################################################################
## Script                                                                     ##
################################################################################
## Parse the command line args
while [[ $# -gt 1 ]]; do
    key="$1"

    case $key in
        ## Base dir.
        --basedir)
            BASE_DIR="$2";
            shift;
        ;;
        ## Local dir.
        --localdir)
            LOCAL_DIR="$2";
            shift;
        ;;
        ## Output dir.
        --outputdir)
            OUTPUT_DIR="$2";
            shift;
        ;;
        ## Dots dir.
        --dotsdir)
            DOTS_DIR="$2";
            shift;
        ;;
        ## Base files.
        --basefiles)
            ## Will loop until another --option or runs out of arguments.
            while [ true ]; do
                if [[ "$2" == "--"* ]]; then
                    break;
                fi;

                if [ "$#" == "0" ]; then
                    break;
                fi;

                BASE_FILES+="$2 "
                shift;
            done
        ;;
        ## Local files.
        --localfiles)
            ## Will loop until another --option or runs out of arguments.
            while [ true ]; do
                if [[ "$2" == "--"* ]]; then
                    break;
                fi;

                if [ "$#" == "0" ]; then
                    break;
                fi;

                LOCAL_FILES+="$2 "
                shift;
            done
        ;;

        *)
        ;;
    esac

    shift # past argument or value
done

## Copy the files to output folder.
##          Files          Files Directory.
copy_files "$BASE_FILES"  "$BASE_DIR"
copy_files "$LOCAL_FILES" "$LOCAL_DIR"

## Add the files to source to main.sh
add_to_main "$BASE_FILES"
add_to_main "$LOCAL_FILES"

#!/bin/bash

################################################################################
## Variables                                                                  ##
################################################################################
BASE_DIR="$1";
LOCAL_DIR="$2";
OUTPUT_DIR="$3";
DOTS_DIR="$4";


BASE_FILES="AmazingCow.sh                \
            bash-status-line_bindings.sh \
            coreutils.sh                 \
            development.sh               \
            git.sh                       \
            hacks.sh                     \
            ps1.sh";

LOCAL_FILES="files.sh";


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
        echo "Copying ($FULLPATH) to ($OUTPUT_DIR)";
        mkdir -p $OUTPUT_DIR;
        cp $FULLPATH $OUTPUT_DIR;

    done;
}


add_to_main() {
    FILES=$1;

    for FILENAME in $FILES; do
        echo "Adding to main.sh: ($FILENAME)";
        echo "source" "$DOTS_DIR/$FILENAME" >> "$OUTPUT_DIR/main.sh";
    done;
}


################################################################################
## Script                                                                     ##
################################################################################
##          Files          Files Directory.
copy_files "$BASE_FILES"  "$BASE_DIR"
copy_files "$LOCAL_FILES" "$LOCAL_DIR"


add_to_main "$BASE_FILES"
add_to_main "$LOCAL_FILES"

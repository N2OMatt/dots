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
## Script                                                                     ##
################################################################################
echo "----> Calling dots install_helper.sh";
./install_helper.sh             \
    --basedir    "./base"       \
    --localdir   "$OS"          \
    --outputdir  "./output"     \
    --dotsdir    "$DOTS_DIR"    \
    --basefiles  "$BASE_FILES"  \
    --localfiles "$LOCAL_FILES"

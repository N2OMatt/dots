#!/usr/bin/env bash

##----------------------------------------------------------------------------##
## Variables                                                                  ##
##----------------------------------------------------------------------------##
OS=$1;
DOTS_DIR=$2

BASE_FILES="bash-status-line_bindings.sh \
            coreutils.sh                 \
            development.sh               \
            editor.sh                    \
            git.sh                       \
            hacks.sh                     \
            manual.sh                    \
            youtube-dl.sh                \
            ps1.sh";

LOCAL_FILES="files.sh";


##----------------------------------------------------------------------------##
## Script                                                                     ##
##----------------------------------------------------------------------------##
echo "----> Calling dots install_helper.sh";
echo "------> OS       : $OS";
echo "------> DOTS_DIR : $DOTS_DIR";

./install_helper.sh             \
    --basedir    "./base"       \
    --localdir   "$OS"          \
    --outputdir  "./output"     \
    --dotsdir    "$DOTS_DIR"    \
    --basefiles  "$BASE_FILES"  \
    --localfiles "$LOCAL_FILES"

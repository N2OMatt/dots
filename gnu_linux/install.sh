#!/bin/bash
################################################################################
## File    : install.sh                                                       ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Installation script for GNU machines.                                      ##
################################################################################

################################################################################
## Variables                                                                  ##
################################################################################
OS=$1;
DOTS_DIR=$2

BASE_FILES="AmazingCow.sh                \
            bash-status-line_bindings.sh \
            coreutils.sh                 \
            development.sh               \
            git.sh                       \
            hacks.sh                     \
            youtube-dl.sh                \
            ps1.sh";

LOCAL_FILES="apt.sh         \
             browser.sh     \
             cocos.sh       \
             connections.sh \
             files.sh       \
             gosh.sh        \
             manual.sh";


################################################################################
## Script                                                                     ##
################################################################################
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
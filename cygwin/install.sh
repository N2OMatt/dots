#!/bin/bash
################################################################################
## File    : install.sh                                                       ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Installation script for Cygwin machines.                                   ##
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
            TBS.sh                       \
            youtube-dl.sh                \
            ps1.sh";

LOCAL_FILES="files.sh           \
             cygwin_hacks.sh    \
             cygpath_helpers.sh \
             firehorse_hacks.sh";


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


echo "----> Configuring git...";
git config --global core.preloadindex       true;
git config --global core.fscache            true;
git config --global gc.auto                 256;
git config --global status.submoduleSummary false;

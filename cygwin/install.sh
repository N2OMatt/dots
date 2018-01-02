#!/usr/bin/env bash
##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : install.sh                                                    ##
##  Project   : dots                                                          ##
##  Date      : Feb 24, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2017, 2018                                          ##
##                                                                            ##
##  Description :                                                             ##
##    Installation script for Cygwin machines.                                ##
##---------------------------------------------------------------------------~##

##----------------------------------------------------------------------------##
## Variables                                                                  ##
##----------------------------------------------------------------------------##
OS=$1;
DOTS_DIR=$2

BASE_FILES="bash-status-line_bindings.sh \
            coreutils.sh                 \
            development.sh               \
            git.sh                       \
            hacks.sh                     \
            manual.sh                    \
            youtube-dl.sh                \
            ps1.sh";

LOCAL_FILES="files.sh           \
             cygwin_hacks.sh    \
             cygpath_helpers.sh";


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


##------------------------------------------------------------------------------
## Configure git.
## COWTODO(n2omatt): check if this is still correct...
echo "----> Configuring git...";
git config --global core.preloadindex       true;
git config --global core.fscache            true;
git config --global gc.auto                 256;
git config --global status.submoduleSummary false;


##------------------------------------------------------------------------------
## COWNOTE(n2omatt): This is due cygwin don't provide
##    sudo command, and we want that GNU/Linux scripts
##    that require it works without modification.
##
##  Notice that isn't a real things, we're just
##  forwarding the arguments...
echo "----> Installing (fake) sudo...";
echo "#!/usr/bin/bash "  > /usr/bin/sudo
echo '"$@"'             >> /usr/bin/sudo
chmod 755 /usr/bin/sudo

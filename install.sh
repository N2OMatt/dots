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
##  Date      : May 25, 2016                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2016 - 2018                                         ##
##                                                                            ##
##  Description :                                                             ##
##    Installation script for dots.                                           ##
##---------------------------------------------------------------------------~##

##----------------------------------------------------------------------------##
## Imports                                                                    ##
##----------------------------------------------------------------------------##
source /usr/local/src/acow_shellscript_utils.sh


##----------------------------------------------------------------------------##
## Variables                                                                  ##
##----------------------------------------------------------------------------##
REAL_USER_HOME=$(find_real_user_home);

OS_TYPE=$($(whereis simple-os-name | cut -d":" -f2) --type);
BASHRC="$REAL_USER_HOME/.bashrc";
DOTS_DIR="$REAL_USER_HOME/.${OS_TYPE}_dots"
BASHRC_ENTRY_FILENAME="$DOTS_DIR/main.sh"


##----------------------------------------------------------------------------##
## Script                                                                     ##
##----------------------------------------------------------------------------##
##------------------------------------------------------------------------------
## Info
center_text " [dots installer] ";
echo "OS        : $OS_TYPE";
echo ".bashrc   : $BASHRC";
echo ".dots dir : $DOTS_DIR";
center_text "-"


##------------------------------------------------------------------------------
## Check .bashrc
if [ ! -e "$BASHRC" ]; then
    echo "--> No bashrc - exiting..."
    exit 1;
fi;

##------------------------------------------------------------------------------
## Check Previous installs.
if [ -e "$DOTS_DIR" ]; then
    echo "--> Found previous installation - Removing it...";
    rm -rf "$DOTS_DIR";
fi;

##------------------------------------------------------------------------------
## Create dots dir and copy all files to it.
echo "--> Creating the dots dir ($DOTS_DIR)";
mkdir -p "$DOTS_DIR";

echo "--> Calling $OS_TYPE install script.";
$OS_TYPE/install.sh $OS_TYPE $DOTS_DIR

echo "--> Copying everything to dots dir ($DOTS_DIR)"
cp -rf ./output/* "$DOTS_DIR";
rm -rf output;

##------------------------------------------------------------------------------
## Search on .bashrc if we already have an entry for dots
## and if not create one!
set +e
GREP_RESULT=$(cat "$BASHRC" | grep "$BASHRC_ENTRY_FILENAME");
set -e

if [ -z  "$GREP_RESULT" ]; then
    echo "--> Did not found an entry in $BASHRC - Creating it...";
    echo "[[ -s \"$BASHRC_ENTRY_FILENAME\" ]] && source \"$BASHRC_ENTRY_FILENAME\"" >> $BASHRC;
else
    echo "--> Found an entry in $BASHRC - Keeping it...";
fi;


echo -e "\nInstalled...";
center_text "";
echo -e "\n";

#!/usr/bin/env bash
################################################################################
## File    : install.sh                                                       ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Installation script for dots.                                              ##
################################################################################


################################################################################
## Variables                                                                  ##
################################################################################
case $(uname -a | tr "[:upper:]" "[:lower:]") in
    *darwin* ) CURR_OS="darwin";    ;;
    *cygwin* ) CURR_OS="cygwin";    ;;
    *linux*  ) CURR_OS="gnu_linux"; ;;
    *freebsd* ) CURR_OS="bsd";      ;;
esac

BASHRC="$HOME/.bashrc";
DOTS_DIR="$HOME/.${CURR_OS}_dots"
BASHRC_ENTRY_FILENAME="$DOTS_DIR/main.sh"


################################################################################
## Script                                                                     ##
################################################################################
## Info
echo "OS        : $CURR_OS";
echo ".bashrc   : $BASHRC";
echo ".dots dir : $DOTS_DIR";

## Check .bashrc
if [ ! -e "$BASHRC" ]; then
    echo "--> No bashrc - exiting..."
    exit 1;
fi;

## Check Previous installs.
if [ -e "$DOTS_DIR" ]; then
    echo "--> Found previous installation - Removing it...";
    rm -rf "$DOTS_DIR";
fi;

## Create dots dir and copy all files to it.
echo "--> Creating the dots dir ($DOTS_DIR)";
mkdir -p "$DOTS_DIR";

echo "--> Calling $CURR_OS install script.";
$CURR_OS/install.sh $CURR_OS $DOTS_DIR

echo "--> Copying everything to dots dir ($DOTS_DIR)"
cp -rf ./output/* "$DOTS_DIR";
rm -rf output;


## Search on .bashrc if we already have an entry for dots
# ## and if not create one!
GREP_RESULT=$(cat "$BASHRC" | grep "$BASHRC_ENTRY_FILENAME");
if [ -z  "$GREP_RESULT" ]; then
    echo "--> Did not found an entry in $BASHRC - Creating it...";
    echo "[[ -s \"$BASHRC_ENTRY_FILENAME\" ]] && source \"$BASHRC_ENTRY_FILENAME\"" >> $BASHRC;
else
    echo "--> Found an entry in $BASHRC - Keeping it...";
fi;

echo "";
echo "Installed...";

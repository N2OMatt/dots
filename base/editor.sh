#/usr/bin/env bash
##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : editor.sh                                                     ##
##  Project   : dots                                                          ##
##  Date      : Jan 20, 2018                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2018                                                ##
##                                                                            ##
##  Description :                                                             ##
##                                                                            ##
##---------------------------------------------------------------------------~##

SUBLIME=$(which subl);
VSCODE=$(which code);
EDITOR="";

test -n "$SUBLIME" && EDITOR="$SUBLIME";
test -n "$VSCODE"  && EDITOR="$VSCODE";

alias editor="$EDITOR ";

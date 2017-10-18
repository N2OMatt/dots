#!/bin/bash
##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : useraddex.sh                                                  ##
##  Project   : dots                                                          ##
##  Date      : Oct 14, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2017                                                ##
##                                                                            ##
##  Description :                                                             ##
##                                                                            ##
##---------------------------------------------------------------------------~##

################################################################################
## Vars                                                                       ##
################################################################################
USER="";
PASSWORD="";
GROUP="";

################################################################################
## Functions                                                                  ##
################################################################################
fatal()
{
    echo "[FATAL] $1";
    exit 1;
}

################################################################################
## Script                                                                     ##
################################################################################
## Parse the options...
while getopts ":u:g:p:" opt; do
    case "$opt" in
        u) USER=$OPTARG;     ;;
        g) GROUP=$OPTARG;    ;;
        p) PASSWORD=$OPTARG; ;;
        :) echo "Invalid option: $OPTARG requires an argument" 1>&2 ;;
    esac
done

shift $((OPTIND-1))

## Sanity checks...
test -z "$USER"     && fatal "user cannot be empty...";
test -z "$GROUP"    && fatal "group cannot be empty...";
test -z "$PASSWORD" && fatal "password cannot be empty...";


## Add user ;D
useradd -m "$USER";
echo "$USER:$PASSWORD" | chpasswd;
usermod -a -G "$GROUP" "$USER";

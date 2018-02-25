##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : gitcheck.sh                                                   ##
##  Project   : TSP                                                           ##
##  Date      : Feb 24, 2018                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2018                                                ##
##                                                                            ##
##  Description :                                                             ##
##                                                                            ##
##---------------------------------------------------------------------------~##

gitcheck-auto-pull()
{
    ##--------------------------------------------------------------------------
    ## Vars
    local FILENAME="$(mktemp /var/tmp/XXXXXXXXXXXXXX)"
    local CWD="$PWD";
    ##--------------------------------------------------------------------------
    ## Run gitcheck.
    echo "Running gitcheck...";
    gitcheck --quiet $@ | sed  's/\x1b\[[0-9;]*m//g' > "$FILENAME";

    while read LINE; do
        ##----------------------------------------------------------------------
        ## Only care about stuff that we can pull...
        local TO_PULL=$(echo "$LINE" | grep "To Pull");
        test -z "$TO_PULL" && continue;

        ##----------------------------------------------------------------------
        ## We don't want mess with repos that stuff to commit yet.
        local TO_COMMIT=$(echo "$LINE" | grep "To Commit");
        test -n "$TO_COMMIT" && continue;

        ##----------------------------------------------------------------------
        ## Nor repos that has stuff to push...
        local TO_PUSH=$(echo "$LINE" | grep "To Push");
        test -n "$TO_PUSH" && continue;

        ##----------------------------------------------------------------------
        ## We're assuming that paths doesn't contains spaces...
        ##   For now this seems reasonable to do on our enviroment.
        local REPO_PART=$(echo $LINE | cut -d" " -f1);
        local REPO_PATH=$(dirname "$REPO_PART");
        local REPO_BRANCH=$(basename "$REPO_PART");

        ##----------------------------------------------------------------------
        ## Pull.
        cd "$REPO_PATH";

        echo "Pull Repo: ($REPO_PATH) - Branch: ($REPO_BRANCH)";
        git pull origin "$REPO_BRANCH"

        cd "$CWD";

    done < $FILENAME
}
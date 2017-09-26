##~---------------------------------------------------------------------------##
##                         ____                       _   _                   ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : git.sh                                                        ##
##  Project   : dots                                                          ##
##  Date      : Feb 15, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2017                                                ##
##                                                                            ##
##  Description :                                                             ##
##      Functions and aliases to ease the git operation                       ##
##---------------------------------------------------------------------------~##

################################################################################
## Aliases                                                                    ##
################################################################################
#Less typing FTW.
## GUI
alias ggui="git gui";
## Status
alias gstatus="git status -s";
## Log
alias glog="git log";
## Add
alias gadd="git add";
## Commit
alias gcommit="git commit";
## Pull
alias gpull="git pull";
## Tags
alias gtag="git tag";
## Submodule
alias gsub-uir="git submodule update --init --recursive";
alias gsub-add="git submodule add";
## Authors
alias gauthors="git log --format=\"%aN - <%ae>\" | sort | uniq";
alias gauthors-top="git shortlog -s -n"
## Branch
alias gbranch="git branch";
alias gbranch-curr="git rev-parse --abbrev-ref HEAD";
alias gbranch-create="git checkout -b";
## Push
alias gpush="git push --tags";


################################################################################
## Push Functions                                                             ##
################################################################################
gpush-curr()
{
    git push --tags origin $(gbranch-curr);
}


################################################################################
## URL Functions                                                              ##
################################################################################
gurl()
{
    git remote -v | head -1 | expand -t1 | cut -d" " -f2;
}

gurl-browser()
{
    browser $(gurl)
}


################################################################################
## Merge Functions                                                            ##
################################################################################
gmerge-curr()
{
    gmerge $(gbranch-curr) $1;
}

gmerge()
{
    SRC_BRANCH="$1";
    DST_BRANCH="$2";

    git checkout $DST_BRANCH;
    git merge --no-ff $SRC_BRANCH;
}


################################################################################
## Branch Functions                                                           ##
################################################################################
git-delete-all-branches-but-master()
{
    git-delete-all=branches-but-this master;
}

git-delete-all-branches-but()
{
    local branch_to_delete="$1";
    local curr_branch=$(gbranch-curr);
    # local force="$1";

    ## Check if we are on master.
    ##   Only delete other branches if we're on master.
    if [ "$curr_branch" != "$branch_to_delete" ]; then
        echo "[FATAL] Not on $branch_to_delete branch. - Currently on [$curr_branch]";
        return 1;
    fi;

    ## Delete all branches
    for curr_branch in $(git branch | cut -c 3-); do
        ## Skip master branch (and empty lines)
        if [ "$curr_branch" == "$branch_to_delete" ]; then
            continue;
        fi;

        # ## User specified --force or -f flags
        # ##   This means that we don't need ask anything...
        # if [ "$force" != "--force" ] && [ "$force" != "-f" ]; then

        #     echo -n "Delete branch [$curr_branch]: [Y/n]";
        #     read YES;

        #     if [ "$YES" == "n" ] || [ "$YES" == "N" ]; then
        #         echo "  Skipping branch [$curr_branch]";
        #         continue;
        #     fi;
        # fi;

        git branch -D "$curr_branch"
    done;
}

################################################################################
## Submodule Functions                                                        ##
################################################################################
gsub-remove()
{
    local SUBNAME="$1";

    if [ -z "$SUBNAME" ]; then
        echo "[FATAL] Missing submodule name...";
        return -1;
    fi;

    git rm -f "$SUBNAME";
    rm -rf .git/modules/"$SUBNAME"
}

################################################################################
## Status Functions                                                           ##
################################################################################
gmod-list()
{
    if [ -z "$1" ]; then
        git status;
    else
        git status | grep -i $1
    fi;
}


################################################################################
## Git Ignore Functions                                                       ##
################################################################################
gignore-jetbrains()
{
    local GITIGNORE_MARK="## JETBRAINS GITIGNORE MARK ##";
    if [ -f .gitignore ]; then
        local CONTENTS=$(cat .gitignore | grep "$GITIGNORE_MARK");
        if [ -n "$CONTENTS" ]; then
            return;
        fi;
    fi;

    local URL="https://raw.githubusercontent.com/github/gitignore/master/Global/JetBrains.gitignore";

    echo $GITIGNORE_MARK >> .gitignore;
    wget -qO- $URL >> .gitignore;
}

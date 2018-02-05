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

##----------------------------------------------------------------------------##
## Aliases                                                                    ##
##----------------------------------------------------------------------------##
#Less typing FTW.
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
## Config
alias git-ignore-filemodes="git config  core.filemode false";

function get_git_path()
{
    local os_kernel=$(simple-os-name --kernel);
    local os_type=$(simple-os-name --type);

    ##--------------------------------------------------------------------------
    ## We're on Windows - So we need be trick with the paths...
    if [ "$os_kernel" == "microsoft" ]; then
        test "$os_type" == "gnu_linux" && WINPATH="/mnt";
        test "$os_type" == "cygwin"    && WINPATH="/cygdrive";
        test "$os_type" == "msys"      && WINPATH="";
        test "$os_type" == "mingw"     && WINPATH="";

        echo "$WINPATH/c/Program Files/Git/cmd";

    ##--------------------------------------------------------------------------
    ## Standard Unix...
    else
        echo $(dirname $(which git));
    fi;
}

function get_executable_suffix()
{
    local os_kernel=$(simple-os-name --kernel);
    if [ "$os_kernel" == "microsoft" ]; then
        echo ".exe";
    fi;
}


##----------------------------------------------------------------------------##
## GUI                                                                        ##
##----------------------------------------------------------------------------##
function ggui()
{
    OLD_CWD="$PWD";
    if [ -d "$1" ]; then
        cd "$1";
    fi;

    local git_path="$(get_git_path)";
    local exe_suffix="$(get_executable_suffix)";

    "$git_path/"git"$exe_suffix" gui &

    cd "$OLD_CWD";
}


ggui-all()
{
    for TOPDIR in $@; do
        for DIR in $(ls $TOPDIR); do
            cd $TOPDIR/$DIR;

            ## COWTODO(n2omatt): check if we're on git repo...
            IS_DIRTY=$(git status -s);
            if [ -n "$IS_DIRTY" ]; then
                ggui &
            fi;

            cd - > /dev/null 2>&1;
        done
    done
}


##----------------------------------------------------------------------------##
## Push Functions                                                             ##
##----------------------------------------------------------------------------##
gpush-curr()
{
    git push --tags origin $(gbranch-curr);
}


##----------------------------------------------------------------------------##
## URL Functions                                                              ##
##----------------------------------------------------------------------------##
gurl()
{
    git remote -v | head -1 | expand -t1 | cut -d" " -f2;
}

gurl-browser()
{
    browser $(gurl)
}


##----------------------------------------------------------------------------##
## Merge Functions                                                            ##
##----------------------------------------------------------------------------##
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


##----------------------------------------------------------------------------##
## Branch Functions                                                           ##
##----------------------------------------------------------------------------##
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

git-delete-all-branches-but-master()
{
    git-delete-all-branches-but master;
}


##----------------------------------------------------------------------------##
## Submodule Functions                                                        ##
##----------------------------------------------------------------------------##
gsub-add-libs()
{
    for LIB in $@; do
        git submodule add https://github.com/AmazingCow-Libs/$LIB;
    done;
}

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

##----------------------------------------------------------------------------##
## Status Functions                                                           ##
##----------------------------------------------------------------------------##
gmod-list()
{
    if [ -z "$1" ]; then
        git status;
    else
        git status | grep -i $1
    fi;
}


##----------------------------------------------------------------------------##
## Git Ignore Functions                                                       ##
##----------------------------------------------------------------------------##
gignore-jetbrains()
{
    MARK="## JETBRAINS GITIGNORE MARK ##";
    URL="https://raw.githubusercontent.com/github/gitignore/master/Global/JetBrains.gitignore";

    gitignore-update "$MARK" "$URL";
}

gignore-visualstudio()
{
    MARK="## VISUAL GITIGNORE MARK ##";
    URL="https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore";

    gitignore-update "$MARK" "$URL";
}

gitignore-update()
{
    local GITIGNORE_MARK="$1";
    if [ -f .gitignore ]; then
        echo "Found .gitignore";

        local CONTENTS=$(cat .gitignore | grep "$GITIGNORE_MARK");
        if [ -n "$CONTENTS" ]; then
            echo "Found $GITIGNORE_MARK - Skipping...";
            return;
        fi;
    fi;

    echo "Downloading gitignore...";
    local URL="$2";
    echo $GITIGNORE_MARK >> .gitignore;
    wget -qO- $URL >> .gitignore;

    echo "Done...";
    echo "";

    head .gitignore;
}

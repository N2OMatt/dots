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
    local ALL_DIRS="$@";
    test -z "$ALL_DIRS" && ALL_DIRS=".";

    for TOPDIR in $ALL_DIRS; do
        echo "Checking ($TOPDIR)";

        for DIR in $(ls $TOPDIR); do
            echo "-- Entering: (${TOPDIR}/${DIR})";
            cd "${TOPDIR}/${DIR}";

            ## COWTODO(n2omatt): check if we're on git repo...
            local IS_DIRTY=$(git status -s);
            if [ -n "$IS_DIRTY" ]; then
                echo "---- Dirty...";
                ggui &
            else
                echo "---- Clean...";
            fi;

            cd - > /dev/null 2>&1;
        done
    done
}

gtk()
{
    gitk --all &
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
gmerge-curr-into()
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
    local SUBMODULE_NAME=$(trim "$1" "/");
    local SUBMODULE_PATH=$(trim "$1" "/");

    echo "Removing submodule: $SUBMODULE_NAME";

    set -e; ## Fail fast here...

    git config -f .git/config --remove-section submodule."$SUBMODULE_NAME";
    git config -f .gitmodules --remove-section submodule."$SUBMODULE_NAME";

    git add .gitmodules;
    git rm --cached "$SUBMODULE_PATH";

    git commit -m "- Removing submodule: ($SUBMODULE_NAME).";

    rm -rf "$SUBMODULE_PATH";
    rm -rf .git/modules/"$SUBMODULE_NAME";

    set +e; ## Disable: (Fail fast here...)
}

gsub-pull-all()
{
    local MODULES_PATHS=$(cat .gitmodules | grep path | cut -d"=" -f2);
    for MODULE_PATH in $MODULES_PATHS; do
        cd $MODULE_PATH;

        local HAS_CHANGES=$(git status -suno);
        if [ -n "$HAS_CHANGES" ]; then
            echo "$MODULE_PATH has changes: ";
            echo "$HAS_CHANGES";
        else
            git pull --quiet origin $(gbranch-curr);
        fi;

        cd -;
    done;
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

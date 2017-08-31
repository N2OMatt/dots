################################################################################
## File    : git.sh                                                           ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Define aliases for easy the git.                                           ##
################################################################################


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
alias gpush-curr="git push --tags origin $(gbranch-curr)";

################################################################################
## Functions                                                                  ##
################################################################################
gurl()
{
    git remote -v | head -1 | expand -t1 | cut -d" " -f2;
}

gurl-browser()
{
    browser $(gurl)
}


git-delete-all-branches-but-master()
{
    local curr_branch=$(gbranch-curr);
    local force="$1";

    ## Check if we are on master.
    ##   Only delete other branches if we're on master.
    if [ "$curr_branch" != "master" ]; then
        echo "[FATAL] Not on master branch. - Currently on [$curr_branch]";
        return 1;
    fi;

    ## Delete all branches
    for curr_branch in $(git branch | cut -c 3-); do
        ## Skip master branch (and empty lines)
        if [ "$curr_branch" == "master" ]; then
            continue;
        fi;

        ## User specified --force or -f flags
        ##   This means that we don't need ask anything...
        if [ "$force" != "--force" ] && [ "$force" != "-f" ]; then

            echo -n "Delete branch [$curr_branch]: [Y/n]";
            read YES;

            if [ "$YES" == "n" ] || [ "$YES" == "N" ]; then
                echo "  Skipping branch [$curr_branch]";
                continue;
            fi;
        fi;

        git branch -D "$curr_branch"
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

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
alias ggui="git gui";
alias gtag="git tag";
alias gstatus="git status -s";
alias glog="git log";
alias gadd="git add";
alias gcommit="git commit";
alias gpush="git push --tags";
alias gpull="git pull";
alias gsub-uir="git submodule update --init --recursive";
alias gsub-add="git submodule add";
alias gauthors="git log --format=\"%aN - <%ae>\" | sort | uniq";
alias gauthors-top="git shortlog -s -n"


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

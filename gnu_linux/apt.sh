################################################################################
## File    : apt.sh                                                           ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Functions and aliases to easy the life with apt                            ##
################################################################################


################################################################################
## alias                                                                      ##
################################################################################
# Update and Upgrade the system in one shot.
alias apt-update-upgrade="sudo apt-get update -y && sudo apt-get upgrade -y"


################################################################################
## Functions                                                                  ##
################################################################################
# Shows info about the given package.
apt-show()
{
    if [ -z "$1" ]; then
        echo "Usage: apt-show <package-name>"
        return 1;
    fi;

    apt-cache show $1
}


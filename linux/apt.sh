################################################################################
## apt                                                                        ##
## COWTODO: Add description                                                   ##
################################################################################


## Alias ##
alias apt-update-upgrade="sudo apt-get update -y && sudo apt-get upgrade -y"

## Functions ##
apt-show()
{
    apt-cache show $1
}


## apt ##
alias apt-update-upgrade="sudo apt-get update -y && sudo apt-get upgrade -y"

apt-show()
{
    apt-cache show $1
}


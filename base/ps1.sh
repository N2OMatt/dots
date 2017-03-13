################################################################################
## File    : ps1.sh                                                           ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Makes the prompt more nicer.                                               ##
################################################################################

#Makes my prompt be:
#   Amanda:Directory n2omatt $
#Where Amanda is random colored - Without the black.
PS1="\[$(tput setaf $(( 1 + RANDOM % 7)) )\]\h\[$(tput sgr 0)\]:\W \u\$ "

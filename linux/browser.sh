################################################################################
## File    : browser.sh                                                       ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Define browser stuff for scripts and interactive shell usage.              ##
################################################################################

################################################################################
## Aliases                                                                    ##
################################################################################
# This will make very easy to open the browsers from command line.
alias chrome="chromium-browser";
alias browser="chrome";


################################################################################
## Exports                                                                    ##
################################################################################
# Export the name as a facility to any of my scripts to open my selected
# browser, since it could not know about my aliases.
export N2OBROWSER="chromium-browser";


################################################################################
## Functions                                                                  ##
################################################################################
## Make a google search and opens the result on browser.
google-search()
{
    #Encode the all function arguments.
    local url=$(url-encode $@);

    #Redirect the error output...
    browser "https://www.google.com/search?q=$url" 2>&1 1> /dev/null;
}

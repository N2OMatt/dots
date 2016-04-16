################################################################################
## apt                                                                        ##
## COWTODO: Add description                                                   ##
################################################################################

## Alias ##
alias chrome="chromium-browser";
alias browser="chrome";


## Exports ##
export N2OBROWSER="chromium-browser";


## Functions ##
## Make a google search and opens the result on browser.
google-search()
{
    #Encode the all function arguments.
    local URL=$(url-encode $@)

    #Redirect the error output...
    browser "https://www.google.com/search?q=$URL" 2> /dev/null;
}

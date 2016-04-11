alias chrome="chromium-browser";
alias browser="chrome";

## Make a google search and opens the result on browser.
google-search()
{
    #Encode the all function arguments.
    local URL=$(url-encode $@)

    #Redirect the error output...
    browser "https://www.google.com/search?q=$URL" 2> /dev/null;
}

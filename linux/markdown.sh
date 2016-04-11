## Markdown ##
markdown-view()
{
    if [ -z $1 ]; then
        echo "Usage:"
        echo "  markdown-view <file>"
        exit 1;
    fi;

    markdown $1 > /tmp/$1.html &&  browser /tmp/$1.html
}

## Grip ##
alias grip="python /home/n2omatt/.local/lib/python2.7/site-packages/grip"

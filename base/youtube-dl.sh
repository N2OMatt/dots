################################################################################
## File    : hacks.sh                                                         ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Functions to ease even more the youtube-dl.                                ##
################################################################################

################################################################################
## Functions                                                                  ##
################################################################################
youtube-dl-auto()
{
    local mp3="false";
    local retry="false";

    while [ $# -gt 0 ]; do
        case $1 in
            -m | --mp3   ) mp3="true";    ;;
            -r | --retry ) retry="true";  ;;
                       * ) url=$1;        ;;
        esac;
        shift;
    done;

    local flags="";
    if [ "$mp3" == "true" ]; then
        flags="--extract-audio --audio-format mp3";
    fi;

    echo "MP3  : $mp3";
    echo "Retry: $retry";
    echo "URL  : $url";

    while true; do
        youtube-dl $flags "$url";
        if [ $? == 0 ] || [ $retry == "false" ]; then
            exit;
        fi;
    done;
}

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
youtube-dl-continue()
{
    while true; do
        youtube-dl $1
        if [[ $? == 0 ]]; then
            exit;
        fi
    done

}

youtube-dl-auto()
{
    youtube-dl $1 && exit;
}

youtube-dl-mp3()
{
    youtube-dl $1 --extract-audio --audio-format mp3 && exit
}

################################################################################
## apt                                                                        ##
## COWTODO: Add description                                                   ##
################################################################################

## Functions ##
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

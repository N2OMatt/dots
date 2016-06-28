################################################################################
## apt                                                                        ##
## COWTODO: Add description                                                   ##
################################################################################

## Functions ##

youtube-dl-auto()
{
    youtube-dl $1 && exit;
}

youtube-dl-mp3()
{
    youtube-dl $1 --extract-audio --audio-format mp3 && exit
}

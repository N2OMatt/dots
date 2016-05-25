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
     # youtube-dl-mp3  https://www.youtube.com/watch?v=3wKGLMyOinw
    local download_name=$(echo "$1" | sed s/"https:\/\/www\.youtube\.com\/watch?v="//g);
    youtube-dl $1

    local original_file=$(ls *$download_name*);
    local target_file=$(echo $original_file | \
                        sed s/\.mkv/\.mp3/g | \
                        sed s/\.mp4/\.mp3/g);

    ffmpeg -i "$original_file" -vn -c:a libmp3lame "$target_file";

    rm "$original_file";
}

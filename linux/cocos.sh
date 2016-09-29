################################################################################
## File    : apt.sh                                                           ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Cocos2dx stuff                                                             ##
################################################################################

create-cocos-project()
{
    GAME_NAME="$1"
    GAME_NAME_LOWER=$(echo $1 | tr '[:upper:]' '[:lower:]');

    PRORTRAIT=$2

    cocos new -p "com.amazingcow.$GAME_NAME_LOWER"           \
        -d .                                                 \
        --ios-bundleid "com.amazingcow.$GAME_NAME_LOWER.ios" \
        --mac-bundleid "com.amazingcow.$GAME_NAME_LOWER.mac" \
        -l cpp                                               \
        $PRORTRAIT                                           \
        $GAME_NAME

}

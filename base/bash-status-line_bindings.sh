################################################################################
## File    : bash-status-line_bindings.sh                                     ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Define keyboard bindings to make bash-status-line works correctly.         ##
################################################################################

################################################################################
## Bindings                                                                   ##
################################################################################
if [ -n "$TERM" ]; then
    bind -x '"\C-l":clear; $PROMPT_COMMAND' > /dev/null 2>&1;
fi;

#!/bin/bash
################################################################################
## File    : cygpath_helpers.sh                                               ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Some wrappers to easy the path convertions (fuck nt...)                    ##
################################################################################


## COWTODO(n2omatt): There're some places that the
##   functions don't work as expect. Specially when we're
##   using spaces and ( ) chars.
nt_path()
{
    echo $(cygpath --absolute --mixed "$@");
}

unix_path()
{
    echo $(cygpath --absolute --unix "$@");
}

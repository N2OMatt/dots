################################################################################
## File    : development.sh                                                   ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Define some aliases for development programs.                              ##
################################################################################


## clang / g++ ##
alias g++="g++ -std=c++11"       #C++11 by default.
alias clang="clang++ -std=c++11" #C++11 by default.

print_includes()
{
    START_PATH="$1";
    if [ -z "$START_PATH" ]; then
        START_PATH=".";
    fi;

    find $1 -name "*.h" -or -iname "*.cpp" | xargs grep -E '#include'
}
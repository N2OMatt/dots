################################################################################
## File    : TBS.sh                                                           ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Aliases and functions to ease the build of The Banner Saga projects.       ##
################################################################################


################################################################################
## Functions                                                                  ##
################################################################################
tbs-build()
{
    CURR_OS="";
    case $(uname -a | tr "[:upper:]" "[:lower:]") in
        *darwin* ) CURR_OS="mac";   ;;
        *cygwin* ) CURR_OS="win";   ;;
        *linux*  ) CURR_OS="linux"; ;; ## We actually don't use linux (yet...)
    esac

    IS_IN_SAGA_DIR=$(echo $PWD | grep "saga.-desktop/build");
    if [ -z "$IS_IN_SAGA_DIR" ]; then
        echo "Not in Saga build dir. Aborting build.";
        return 1;
    fi;

    HG_BRANCH=$(hg branch);
    IS_ON_FH_BRANCH=$(echo $HG_BRANCH | grep "firehorse");
    if [ -z "$IS_ON_FH_BRANCH" ]; then
        echo "Not in Firehorse branch. Aborting build.";
        return 1;
    fi;

    SAGA_SKU=$(echo "$HG_BRANCH" | sed s/-firehorse/""/g);
    echo "Building $SAGA_SKU - For OS $CURR_OS";
    echo "   command: ant -f build-$SAGA_SKU.xml local info game-$CURR_OS-$SAGA_SKU";

    ant -f build-$SAGA_SKU.xml local info game-$CURR_OS-$SAGA_SKU
}

tbs-hg-pull()
{
    IS_IN_SAGA_DIR=$(echo $PWD | grep "saga.-desktop");
    if [ -z "$IS_IN_SAGA_DIR" ]; then
        echo "Not in Saga build dir. Aborting build.";
        return 1;
    fi;

    HG_BRANCH=$(hg branch);
    SAGA_SKU=$(echo "$HG_BRANCH" | sed s/-firehorse/""/g);

    hg pull --branch $SAGA_SKU;
}
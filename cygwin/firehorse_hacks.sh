################################################################################
## File    : firehorse_hacks.sh                                               ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Some hacks need for my work at firehorse!                                  ##
## This stuff is need to make the cygwin works "correctly"                    ##
################################################################################

## Make the cygwin sees the NT tools need to build TBS!
ANT_HOME=/cygdrive/c/apache-ant-1.10.1
JAVA_HOME=/cygdrive/c/Program\ Files/Java/jdk1.8.0_131
PATH="$PATH:$ANT_HOME/bin:$JAVA_HOME/bin";

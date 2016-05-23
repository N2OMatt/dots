################################################################################
## Exports                                                                    ##
################################################################################
export AMAZING_COW_PROJECTS_DIRECTORY="/home/$USER/Documents/Projects/AmazingCow";


IS_HOSTGATOR=$(uname -n | grep "hostgator")
if [ -n "$IS_HOSTGATOR"]; then
    export AMAZINGCOW_ENV_DOXYGEN="/home/amazi671/bin/doxygen"
    export AMAZINGCOW_ENV_MARKDOWN="/home/amazi671/bin/markdown"
else
    export AMAZINGCOW_ENV_DOXYGEN=$(whereis  -b doxygen   | cut -d" " -f2);
    export AMAZINGCOW_ENV_MARKDOWN=$(whereis -b markdown  | cut -d" " -f2);
fi

connect_amazingcow_dot_com()
{
    ssh -p2222 amazi671@amazingcow.com
}

##COWTODO: Clean up and possible remove this file.

################################################################################
## Connections                                                                ##
################################################################################
connect_amazingcow_dot_com()
{
    ssh amazingcow@107.180.47.65
}

connect_helena()
{
    ssh n2omatt@192.168.0.120
}

connect_amanda()
{
    ssh mesquitax@192.168.0.121
}


################################################################################
## Mounts                                                                     ##
################################################################################
mount_amanda()
{
    sshfs mesquitax@192.168.0.121:/Users/mesquitax amanda
}
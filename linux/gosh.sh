## This is a version of Gosh (using gosh actually) that lets us
## change the directory (open new window) in the file manager.
goshfiles()
{
    RET=`gosh -p $1`
    if [ $? = 0 ]; then
        files $RET;
    else
        echo $RET;
    fi;
}


## Litte hack that enables the bash completes the stuff for goshf too.
## COWTODO: There is another better way to do this???
BASH_COMPLETION_DIR=$(pkg-config --variable=completionsdir bash-completion);
if [ -f $BASH_COMPLETION_DIR/gosh ]; then
    if [ ! -e $BASH_COMPLETION_DIR/goshfiles ]; then
        echo $BASH_COMPLETION_DIR/gosh $BASH_COMPLETION_DIR/goshfiles
        sudo cp -f $BASH_COMPLETION_DIR/gosh $BASH_COMPLETION_DIR/goshfiles
        sudo bash -c "echo \"complete -F _gosh goshfiles\" >> $BASH_COMPLETION_DIR/goshfiles"
        source $BASH_COMPLETION_DIR/goshfiles
    fi;
fi;
unset BASH_COMPLETION_DIR

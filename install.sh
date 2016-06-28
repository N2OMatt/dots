
if [ -e $HOME/.bashrc ]; then	
	## Clean up previous dots.
	rm -rf $HOME/.linux_dots   
	
	## Copy the new ones.
    mkdir -p $HOME/.linux_dots 
    cp -rf ./linux/* $HOME/.linux_dots

    ## Search on .bashrc if we already have an entry for dots
    ## and if not create one!
    FILENAME=$HOME/.linux_dots/linux.sh
    GREP_RESULT=$(cat $HOME/.bashrc | grep "$FILENAME");

    if [ -z  "$GREP_RESULT" ]; then
        echo "[[ -s \"$FILENAME\" ]] && source \"$FILENAME\"" >> $HOME/.bashrc;	
    fi;
    echo "Installed...";
fi
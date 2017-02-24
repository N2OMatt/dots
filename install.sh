

CURR_OS=$(uname -o | tr "[:upper:]" "[:lower:]");
BASHRC="$HOME/.bashrc";
DOTS_DIR="$HOME/.${CURR_OS}_dots"
BASHRC_ENTRY_FILENAME="$DOTS_DIR/main.sh"


echo "OS        : $CURR_OS";
echo ".bashrc   : $BASHRC";
echo ".dots dir : $DOTS_DIR";


if [ ! -e "$BASHRC" ]; then
    echo "No bashrc - exiting..."
    exit 1;
fi;


if [ -e "$DOTS_DIR" ]; then
    echo "Found previous installation - Removing it...";
    rm -rf "$DOTS_DIR";
fi;


## Create dots dir and copy all files to it.
mkdir -p "$DOTS_DIR";
./${CURR_OS}/install.sh base ${CURR_OS} output "$DOTS_DIR";
cp -rf ./output/* "$DOTS_DIR";
rm -rf output;


## Search on .bashrc if we already have an entry for dots
## and if not create one!
GREP_RESULT=$(cat "$BASHRC" | grep "$BASHRC_ENTRY_FILENAME");
if [ -z  "$GREP_RESULT" ]; then
    echo "Did not found an entry in $BASHRC - Creating it...";
    echo "[[ -s \"$BASHRC_ENTRY_FILENAME\" ]] && source \"$BASHRC_ENTRY_FILENAME\"" >> $BASHRC;
else
    echo "Found an entry in $BASHRC - Keeping it...";
fi;

echo "Installed...";

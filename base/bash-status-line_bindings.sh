if [ -n "$TERM" ]; then
    bind -x '"\C-l":clear; $PROMPT_COMMAND' > /dev/null 2>&1;
fi;

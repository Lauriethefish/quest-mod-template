#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
NDKPath=$(cat $SCRIPT_DIR/ndkpath.txt)

stackScript="$NDKPath/ndk-stack"

if [ "$#" -eq "1" ]; then
    cat $SCRIPT_DIR/log.txt | $stackScript -sym $SCRIPT_DIR/obj/local/arm64-v8a/ > $SCRIPT_DIR/log_unstripped.log
else
    $1 | $stackScript -sym $SCRIPT_dir/obj/local/arm64-v8a/ > "$SCRIPT_DIR/$($1)_unstripped.txt"
fi

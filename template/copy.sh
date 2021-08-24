#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
$SCRIPT_DIR/build.sh
if [ $? ]; then
    adb push libs/arm64-v8a/lib#{id}.so /sdcard/Android/data/com.beatgames.beatsaber/files/mods/lib#{id}.so
    if [ $? ]; then
        $SCRIPT_DIR/restart-game.sh
        if [ "$1" -eq "--log" ]; then
            $SCRIPT_DIR/start-logging.sh
        fi
    fi
fi

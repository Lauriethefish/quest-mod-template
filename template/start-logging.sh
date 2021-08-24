#!/bin/sh


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
printf -v timestamp '%(%m-%d %H:%M:%S)T\n' -1
bspid="$(adb shell pidof com.beatgames.beatsaber)"
while [ -z "$bspid" ]; do
    sleep 0.1
    bspid="$(adb shell pidof com.beatgames.beatsaber)"
done
if [ "$#" -eq "1" ]; then
    echo "Start logging!"
    adb logcat -T "$timestamp" --pid $bspid | grep "(QuestHook|modloader|AndroidRuntime)"
fi
if [ "$1" -eq "--file" ]; then
     echo "Logging and saving to file!"
     $(adb logcat -T "$timestamp" --pid $bspid | cat "(QuestHook|modloader|AndroidRuntime)") >> $SCRIPT_DIR/logcat.log
fi

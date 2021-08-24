#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
NDKPath=$(cat $SCRIPT_DIR/ndkpath.txt)

buildScript="$NDKPath/build/ndk-build"

$buildScript NDK_PROJECT_PATH=$SCRIPT_DIR APP_BUILD_SCRIPT=$SCRIPT_DIR/Android.mk NDK_APPLICATION_MK=$SCRIPT_DIR/Application.mk

exit $?

#!/bin/sh
# Builds a .qmod file for loading with QuestPatcher
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
NDKPath=$(cat $SCRIPT_DIR/ndkpath.txt)

buildScript="$NDKPath/build/ndk-build"

ArchiveName="#{id}_v0.1.0.qmod"
TempArchiveName="/tmp/#{id}_v0.1.0.qmod.zip"

$buildScript NDK_PROJECT_PATH=$PSScriptRoot APP_BUILD_SCRIPT=$PSScriptRoot/Android.mk NDK_APPLICATION_MK=$PSScriptRoot/Application.mk
7z a $TempArchiveName $SCRIPT_DIR/libs/arm64-v8a/lib#{id}.so $SCRIPT_DIR/libs/arm64-v8a/libbeatsaber-hook_1_2_4.so $SCRIPT_DIR/mod.json
mv $TempArchiveName $ArchiveName

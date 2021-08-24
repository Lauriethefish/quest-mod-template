#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
rm $SCRIPT_DIR/quest-mod-template.zip
7z a $SCRIPT_DIR/quest-mod-template.zip $SCRIPT_DIR/template/*
echo "Template saved to quest-mod-template.zip"

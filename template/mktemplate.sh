#!/bin/sh

ndkpath="$1"
id="$2"
name="$3"
author="$4"
description="$5"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
for i in $(ls $SCRIPT_DIR); do
        if [ "$i" != "mktemplate.sh" ]; then
            sed -i "s/#{ndkpath}/$ndkpath/g" $SCRIPT_DIR/$i
            sed -i "s/#{id}/$id/g" $SCRIPT_DIR/$i
            sed -i "s/#{name}/$name/g" $SCRIPT_DIR/$i
            sed -i "s/#{author}/$author/g" $SCRIPT_DIR/$i
            sed -i "s/#{description}/$description/g" $SCRIPT_DIR/$i
        fi
done

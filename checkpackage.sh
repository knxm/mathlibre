#!/bin/bash

while read pkg; do
    if apt-cache show "$pkg" > /dev/null 2>&1; then
        echo "FOUND: $pkg"
    else
        echo "NOT FOUND: $pkg"
    fi
done < list.txt


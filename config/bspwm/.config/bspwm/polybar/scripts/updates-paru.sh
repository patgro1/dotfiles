#!/bin/sh

updates=$(paru --query -u | wc -l)

if [ "$updates" -gt 0 ]; then
    echo "$updates"
else
    echo ""
fi

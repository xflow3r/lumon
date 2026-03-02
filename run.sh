#!/bin/sh
/app/MDR
status=$?
if [ $status -eq 1 ]; then
    echo $FLAG
fi

#!/bin/bash

VERSION="0.0.3"
MODIFIED="January 23, 2019"
TOOL_DIR="/usr/bin"

if [ -e "$TOOL_DIR"/task_notify.sh ]; then
    NOTIFIERSCRIPT=task_notify.sh
    PACKAGE=weavedconnectd
    . "$TOOL_DIR"/weavedlibrary
    platformDetection
elif [ -e "$TOOL_DIR"/connectd_task_notify ]; then
    NOTIFIERSCRIPT=connectd_task_notify
    PACKAGE=connectd
    . "$TOOL_DIR"/connectd_library
fi

/usr/bin/python3 /home/demo/pigpio_servo_open.py

ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} a $1 $2 "bar OPEN")
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} 1 $1 $2 "Job complete")

exit

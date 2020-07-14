#!/bin/bash

VERSION="0.0.4"
MODIFIED="June 4, 2020"
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

python3 /usr/local/bin/pigpio_led.py

ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} a $1 $2 "LED blink")
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} 1 $1 $2 "Job complete")

exit

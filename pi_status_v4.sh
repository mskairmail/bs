#!/bin/bash

VERSION="0.0.4"
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

# Clear all status columns A-E in remote.it portal
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} a $1 $2 "")
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} b $1 $2 "")
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} c $1 $2 "")
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} d $1 $2 "")
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} e $1 $2 "")

#-------------------------------------------------
# Update status column A (StatusA) in remote.it portal
#-------------------------------------------------
# retrieve the Linux kernel version
krelease=$(uname -a | awk '{print $3 }')
# send to status column A in remote.it portal
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} a $1 $2 "$krelease")

#-------------------------------------------------
# Update status column B (StatusB) in remote.it portal
#-------------------------------------------------
# retrieve the remote.it connectd version
connectd_version=$(${TOOL_DIR}/${DAEMON}.${PLATFORM} |awk NR==2'{print "connectd " $2}')
# send to status column B in remote.it portal
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} b $1 $2 "$connectd_version")

#-------------------------------------------------
# Update status column C (StatusC) in remote.it portal
#-------------------------------------------------
# retrieve the system uptime
uptime=$(uptime | sed 's/^.*up *//; s/, *[0-9]* user.*$/m/; s/day[^0-9]*/d, /;s/\([hm]\).*m$/\1/;s/:/h, /;s/^//')
# send to status column C in remote.it portal
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} c $1 $2 "$uptime")

#-------------------------------------------------
# Update status column D (StatusD) in remote.it portal
#-------------------------------------------------
# retrieve the temperture
temp=$(vcgencmd measure_temp)
# send to status column D in remote.it portal
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} d $1 $2 "$temp")

#-------------------------------------------------
# Update status column E (StatusE) in remote.it portal
#-------------------------------------------------
# retrieve the date
date=$(date)
# send to status column E in remote.it portal
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} e $1 $2 "$date")

# Lastly finalize job, no updates allowed after this
ret=$(${TOOL_DIR}/${NOTIFIERSCRIPT} 1 $1 $2 "Job complete")

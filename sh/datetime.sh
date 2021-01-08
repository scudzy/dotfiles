#!/usr/bin/env bash
TODAY=$(date +"Today is %A, %d of %B")
TIMENOW=$(date +"The local time is %R")
TIME_UK=$(TZ=BMT date +"The time in the UK is %R")
echo ""
echo $TODAY
echo $TIMENOW
echo $TIME_UK
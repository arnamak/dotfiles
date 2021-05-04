#!/bin/bash

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

FIFO='/tmp/.polybar.fifo'
rm $FIFO &>/dev/null
mkfifo $FIFO

polybar 4k -r &

echo "Bars launched..."

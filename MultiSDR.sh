#!/bin/sh

trap 'pkill -INT rtl_tcp' TERM

DEVICE_COUNT=$((0`rtl_tcp -d -1 2>&1 | grep Found | cut -d " " -f 2`))

for i in `seq 0 $(($DEVICE_COUNT - 1))`
do
  rtl_tcp -d $i -a 0.0.0.0 -p $((1000 + $i)) &
done

sleep 1


# Not very helpful as rtl_tcp seems to never exit
while sleep 60; do
  PROCESS_COUNT=`ps aux | grep rtl_tcp | grep -v grep | wc -l`
  if  [ $DEVICE_COUNT != $PROCESS_COUNT ]; then
    exit 1
  fi
done

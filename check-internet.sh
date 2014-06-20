#/bin/bash

if [ $# -eq 0 ]
then
    echo "Usage: script.sh default-gateway"
    echo "    where default-gateway - ip/dns to ping"
else
    DEFAULT_GATEWAY=$1
    while true
    do
        summary=`ping -c 1 $DEFAULT_GATEWAY | grep -i -o -P "[0-9]* received"`     
        received=`echo $summary | grep -i -o -P "[0-9]*"`
        if [ $received -gt 0 ]
        then         
            break
        fi
        datestr=$(date +%Y.%m.%d)
        timestr=$(date +%H:%M:%S)
        echo "$datestr $timestr: try to ping $DEFAULT_GATEWAY [received: $received]"
    done
    notify-send -t 100000 -i info "Connected"
fi


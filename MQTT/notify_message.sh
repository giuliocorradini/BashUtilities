#!/bin/bash

if [ "$1" == '' ] || [ "$1" == '-h' ]; then
	echo "Usage: $0 [broker hostname] [topic]" &>2
	exit
fi

if [ "$(which mosquitto_sub)" == '' ]; then
	echo "mosquitto_sub is needed for this script to work. Check https://mosquitto.org/download/" &>2
	exit
fi

broker=$1
port=1883
topic=$2

mosquitto_sub -h $broker -t topic | xargs -I % osascript -e 'display notification "%" with title "MQTT"' 2> /dev/null

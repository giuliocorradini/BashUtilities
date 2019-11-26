#!/bin/bash

if [ "$HIDECURSOR" == "1" ]; then
	tput civis
fi

function clearbox {
	startx=$1
	starty=$2
	width=$3
	height=$4
	tput sc
	tput cup $startx $starty
	for ((i=0; i<$height; i++)); do
		tput ech $width
		tput cud1
		tput cuf $starty
	done
	tput rc
}

function clearboxpoint {
	finalx=$3
	finaly=$4
	width=$(($finalx - $1))
	height=$(($finaly - $2))
	clearbox $1 $2 $width $height
}

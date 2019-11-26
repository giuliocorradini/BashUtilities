#!/bin/bash

function solidbg {
	cols=$(tput cols)
	lines=$(tput lines)
	tput setab $1
	for ((i=0; i<$lines; i++)); do
		tput ech $cols
		echo
	done
	tput sgr0
}

function gradientbg {
	tput home
	tput sgr0
	cols=$(tput cols)
	lines=$(tput lines)
	if [ "$(($lines % 5))" == 0 ]; then
		change=$(($lines / 5))
	else
		change=$(($lines / 5 + 1))
	fi
	ln=0
	for ((i=0; i<lines; i++)); do
		if [ "$(($i % $change))" == "0" ]; then ((ln++)); fi
		case $ln in
			1)
				tput setab $1
				tput ech $cols
				tput cud1
				;;
			2)
				tput setaf $2
				for((j=0;j<$cols;j++)); do printf '░%.0s';done
				tput cud1
				;;
			3)
				for((j=0;j<$cols;j++)); do printf '▒%.0s';done
				tput cud1
				;;
			4)
				for((j=0;j<$cols;j++)); do printf '▓%.0s';done
				tput cud1
				;;
			5)
				tput setab $2
				tput ech $cols
				tput cud1
 				;;
		esac
	done
	tput sgr0			
}

function checkerboard {
	startx=$1
	starty=$2
	width=$3
	height=$4
	color=$5
	[ "$color" == '' ] && tput setaf 0 || tput setaf $color; 
	tput cup $startx $starty
	if [ "$starty" == 0 ]; then
		for((i=0; i<height; i++)); do
			for((j=0;j<$width;j++)); do echo -n '▞'; done
			tput cud1
		done
	else
		for((i=0; i<height; i++)); do
			for((j=0;j<$width;j++)); do echo -n '▞'; done
			tput cud1
			tput cuf $starty
		done
	fi
	tput sgr0
}

function checkerboardbg {
	checkerboard 0 0 $(tput cols) $(tput lines) $1 $1
}


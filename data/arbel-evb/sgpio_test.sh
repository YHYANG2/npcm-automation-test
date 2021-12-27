#!/bin/sh
set -e
log_file="/tmp/log/sgpio_test.log"


for ((i=1;i<=10;i++))
do
	gpiomon -n 32 8 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79  > $log_file &
	sleep 0.01
	gpioset 8 0=1 1=1 2=1 3=1 4=1 5=1 6=1 7=1 8=1 9=1 10=1 11=1 12=1 13=1 14=1 15=1
	gpioset 8 0=0 1=0 2=0 3=0 4=0 5=0 6=0 7=0 8=0 9=0 10=0 11=0 12=0 13=0 14=0 15=0
	#sleep 0.01
	Pin_Count=$(awk 'BEGIN{x=0;y=0}{ y++ ; x+=$5 ; if(y==32) print x ;}' $log_file)
	echo $Pin_Count
	if [ "$Pin_Count" != "2288" ]
	then
		echo $i:FAIL  >> $log_file
		exit 1
	else
		echo $i:PASS  >> $log_file
	fi
	sleep 0.01
done

exit 0

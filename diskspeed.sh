#!/bin/bash
testfile=/opt/tempfile.txt

option1=sync
option2=fsync
option3=fdatasync

freespace=$(df -m |sed -n '2p' | awk '{print $4}')
echo $freespace
if [ $(($freespace > 2048)) ]
then
	costtime=$( (time dd if=/dev/zero  of=$testfile bs=8k count=200000 conv=$option3) 2>&1 |grep 'real'|awk '{print $2}')
    echo $costtime
	min=${costtime%m*}
	sectemp=${costtime#*m}
	sec=${sectemp%s*}
	total_time=$(echo "$min*60+$sec" | bc -l)
	if [ $(echo "$total_time>0"|bc) -eq 1 ];then
	    echo "the total time is $total_time secs"
	    average=$( echo "1638.4/$total_time"|bc -l)
	    echo "the speed of this disk is $average Mb/s"
	fi
	rm -rf $testfile
fi

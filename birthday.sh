#!/bin/bash
read -p "birthday YYYYmmdd:" birthday
m=$(date -d "$birthday" +%m)
d=$(date -d "$birthday" +%d)
date_now=$(date +%s)
y=$(date +%Y)
birth=$(date -d "$y$m$d" +%s)
internal=$(($birth - $date_now))
if [ "$internal" -lt "0" ];then
   birth=$(date -d "$(($y+1))$m$d" +%s)   
   internal=$(($birth - $date_now))
fi
echo "There is :$((internal/60/60/24)) days"

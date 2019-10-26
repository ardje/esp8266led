#!/bin/bash
while true;do
while read color;do
sleep 0.48
./sendit.sh $color
done <<EOF
150,0,0,0
0,150,0,0
0,0,150,0
EOF


done

#!/bin/bash

sendfile() {
echo "file.open(\"$1\",\"w\")"
sed 's/\(.*\)/file.writeline[=[\1]=]/' < $1
echo "file.close()"
}

sendfile "$1"| while read aline;do
	echo "$aline"|nc --send-only 192.168.0.178 2323
	sleep 0.2
done

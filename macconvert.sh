#!/bin/bash
#
# Function: MAC Address conversion tool
# Original Author:   sol@subnetzero.org
#
# Usage example: "echo 0000.0000.0000" | macconvert.sh 4d2d

cisco2linux () {
awk '{
print substr($0,1,2)":"\
substr($0,3,2)":"\
substr($0,6,2)":"\
substr($0,8,2)":"\
substr($0,11,2)":"\
substr($0,13,2)}'
}


4dto2d () {
awk '{
print substr($0,1,2)"-"\
substr($0,3,2)"-"\
substr($0,6,2)"-"\
substr($0,8,2)"-"\
substr($0,11,2)"-"\
substr($0,13,2)}'
}

4dto4c () {
awk -F"." '{print $1":"$2":"$3}'
}

2dto4d () {
awk -F"-" '{print $1$2"."$3$4"."$5$6}'
}

2cto4d () {
awk -F":" '{print $1$2"."$3$4"."$5$6}'
}

2cto2d () {
sed 's/:/./g'
}

USAGE="$0 [4d2d] [2d4d] [2c4d] [2c2d] [cisco2linux]
cisco2linux = Convert xxxx.xxxx.xxxx to xx:xx:xx:xx:xx:xx
4d2d = Convert xxxx.xxxx.xxxx to xx-xx-xx-xx-xx-xx
4d4d = Convert xxxx.xxxx.xxxx to xxxx:xxxx:xxxx
2d4d = Convert xx-xx-xx-xx-xx-xx to xxxx.xxxx.xxxx
2c4d = Convert xx:xx:xx:xx:xx:xx to xxxx.xxxx.xxxx
2c2d = Convert xx:xx:xx:xx:xx:xx to xx.xx.xx.xx.xx.xx

Requires input stream from redirect or pipe.
"

case $1 in
        4d2d)   4dto2d;;
        4d4c)   4dto4c;;
        2d4d)   2dto4d;;
        2c4d)   2cto4d;;
        2c2d)   2cto2d;;
	cisco2linux)	cisco2linux;;
        *)      echo "$USAGE";
                exit 1;;
esac

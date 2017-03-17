#!/bin/sh
find_attr()
{
getfattr -R -P -n user.imp /home/vagrant > /tmp/attr 2>/dev/null
cat /tmp/attr  |grep "# file" |cut -f 2 -d : >/tmp/rsync_cp
}

find_attr
lead_slash="/"
while read line1
do 
echo $lead_slash$line1
rsync -alozrPX $lead_slash$line1 /tmp/myfiles/
done </tmp/rsync_cp


#!/bin/bash
#Recursively list all the files with user.comment set.
rm -rf /tmp/file_and_attr
getfattr -n user.comment --absolute-names  -R /home/daya  2>/dev/null |grep file  |awk '{print $3}'  > /tmp/file_with_attr
while read line 
do
echo "For $line"
ATTR=`getfattr -n user.comment --absolute-name --only-values $line` 
echo $line:$ATTR >>/tmp/file_and_attr
done < /tmp/file_with_attr

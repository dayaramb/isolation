#!/bin/sh
eval `ssh-agent`
ssh-add id_rsa

remote_execute(){
   local script
   script=find_attr.sh
   ssh daya@vm1 "bash -s" <"$script"
}

remote_execute
scp daya@vm1:/tmp/rsync_cp /tmp
lead_slash="/"
while read line1
do 
echo $lead_slash$line1
rsync -alozrPX daya@vm1:$lead_slash$line1 /tmp/myfiles/
done </tmp/rsync_cp



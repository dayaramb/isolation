#!/bin/bash
eval `ssh-agent`
ssh-add id_rsa

remote_execute(){
   local script
   script=find_attr.sh
   ssh daya@vm1 "bash -s" <"$script"
}

remote_execute
scp daya@vm1:/tmp/file_and_attr /tmp


#Rsync
while read line 
do
BASE64=`echo $line|cut -f2 -d:`
MYFILE=`echo $line|cut -f1 -d:`
echo $BASE64>/tmp/base64_encoded
cat  /tmp/base64_encoded  |awk '{print $1}' >/tmp/base64
cat  /tmp/base64_encoded  |awk '{print $2}' >>/tmp/base64
cat  /tmp/base64_encoded  |awk '{print $3}' >>/tmp/base64
base64 -d /tmp/base64   > /tmp/attr.enc
openssl rsautl -decrypt -inkey private_key.pem -in /tmp/attr.enc -out /tmp/orig_attr
ORIG_ATTR=`cat /tmp/orig_attr`
FLAG_BIT=`echo ${ORIG_ATTR: -1}`
FILE_NAME=`echo $MYFILE |awk -F "/" '{print $NF}'`
if [[ $FLAG_BIT -eq 1 ]]; then
	
        echo "Backup $FILE_NAME as IMP Flag is set"
        #rsync -alozrPX $MYFILE /tmp/myfiles/
        rsync -alozrPX daya@vm1:$MYFILE /tmp/myfiles/

fi


if [[ $FLAG_BIT -eq 0 ]]; then
        echo "Remove $FILE_NAME as NOT IMP flag is set"
	rm -rf /tmp/myfiles/$FILE_NAME
fi

done </tmp/file_and_attr 

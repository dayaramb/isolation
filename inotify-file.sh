#!/bin/bash
DIR="/home/daya"
#inotifywait -m -r -e create "$DIR" |while read f 
inotifywait -m -r -e modify -e moved_to -e create "$DIR" |while read f 
do
   
  MY_FILE_NAME=`echo $f|awk '{print $NF}'`
  MY_FILE_PATH=$DIR/$MY_FILE_NAME
  FILE_INODE=`ls -di $MY_FILE_PATH |awk '{print $1}'`
        echo "$FILE_INODE"0 >/tmp/fnode
        openssl rsautl -encrypt -inkey public_key.pem -pubin -in /tmp/fnode -out /tmp/fnode.enc
        BASE64_ENC=`base64 /tmp/fnode.enc`
        setfattr -n user.comment -v "$BASE64_ENC" $MY_FILE_PATH
	echo "Done for $MY_FILE_PATH"
done




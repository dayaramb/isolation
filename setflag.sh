#!/bin/bash

#usage ./attr-enc <File or Dir>

#Get Inode No.
FILE_INODE=`ls -i $1 |awk '{print $1}'`
echo "$FILE_INODE"1 >/tmp/fnode
openssl rsautl -encrypt -inkey public_key.pem -pubin -in /tmp/fnode -out /tmp/fnode.enc
BASE64_ENC=`base64 /tmp/fnode.enc`
setfattr -n user.comment -v "$BASE64_ENC" $1





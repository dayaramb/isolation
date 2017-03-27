#!/bin/bash

#usage ./attr-enc <File or Dir>
#Check if the total numbers of attributes is 3 or not 
if [ "$#" -ne 2 ]; then
echo "Usage- setflag +imp|-imp|-r <Filename>"
exit 0
fi


case "$1" in 
    +imp)
   
	#Get Inode No.

	#$2="+imp"|"-imp"

	FILE_INODE=`ls -di $2 |awk '{print $1}'`
	echo "$FILE_INODE"1 >/tmp/fnode
	openssl rsautl -encrypt -inkey public_key.pem -pubin -in /tmp/fnode -out /tmp/fnode.enc
	BASE64_ENC=`base64 /tmp/fnode.enc`
	setfattr -n user.comment -v "$BASE64_ENC" $2
#	rm -f /tmp/fnode
#	rm -f /tmp/fnode.enc
	;;
    -imp)

        FILE_INODE=`ls -di $2 |awk '{print $1}'`
        echo "$FILE_INODE"0 >/tmp/fnode
        openssl rsautl -encrypt -inkey public_key.pem -pubin -in /tmp/fnode -out /tmp/fnode.enc
        BASE64_ENC=`base64 /tmp/fnode.enc`
        setfattr -n user.comment -v "$BASE64_ENC" $2
#       rm -f /tmp/fnode
#       rm -f /tmp/fnode.enc
        ;;



   -r)
	echo "file is:$2"
	setfattr -x user.comment $2
	;;

    *)
	echo "Usage- setflag +imp|-imp|-r <Filename>"

esac

#Ref https://linuxconfig.org/using-openssl-to-encrypt-messages-and-files-on-linux

#Generate key in VM2, Store the private key in VM2 and provide public key to VM1.

#Generate private key
openssl genrsa -out private_key.pem 1024

# From the private key generate the public key
openssl rsa -in private_key.pem -out public_key.pem -outform PEM -pubout



#Encrypt the file
openssl rsautl -encrypt -inkey public_key.pem -pubin -in encrypt.txt -out encrypt.dat 

# Get the Inode 
ls -i 


#Append Zero or 1 at the end of the Inode


#Encrypt the content


#Encode it by base64

# provide it to the setfattr command


 

#Decrypt the file

openssl rsautl -decrypt -inkey private_key.pem -in encrypt.dat -out new_encrypt.txt 



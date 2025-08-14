#!/bin/bash
FTPSERVER=172.16.6.2

ftp -n "$FTPSERVER" 21 <<EOF
user user01 user01
cd test
lcd /test
binary
hash
prompt
passive
mput linux*.txt
bye
EOF

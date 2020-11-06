#!/bin/bash

##########################
# Author Denis Solovev  ##
# email: boostor@mail.ru #
##########################

Fail='Failed password'
ACPT='Accepted password'
inv='invalid' #$9
usr='user' #$10
TABLE='auth'
DB_USER='sysbench_user'
DB_NAME='mydb'
DB_HOST='192.168.100.214'
#DB_PASS
#env
#echo $DB_PASSWD > $DB_PASS 
var1=$(echo "$LINE" | awk '{print $9}')

/usr/bin/tail -n0 -f /var/log/auth.log | \
while read LINE
do
   if echo "$LINE" | grep -E "$Fail|$ACPT" 1>/dev/null 2>&1
   then
      var1=`echo "$LINE" | awk '{print $9}'`
      if [[ "$var1" == "$inv" ]]; then
#         echo "$LINE" | awk '{print $2" "$1" "$3, $6, $11, $13, $16}'
         status=`echo "$LINE" | awk '{print $6}'`
         user=`echo "$LINE" | awk '{print $11}'`
         ip=`echo "$LINE" | awk '{print $13}'`
         data=`echo "$LINE" | awk '{print $2" "$1" "$3}'`
         proto=`echo "$LINE" | awk '{print $16}'`
mysql --host=$DB_HOST --user=$DB_USER --password=$DB_PASSWD $DB_NAME <<EOF
INSERT INTO $TABLE (status, user, ip, data, protocol) VALUES ("$status", "$user", "$ip", "$data", "$proto");
EOF
      else
#         echo "$LINE" | awk '{print $2" "$1" "$3, $6, $9, $11, $14}'
         status=`echo "$LINE" | awk '{print $6}'`
         user=`echo "$LINE" | awk '{print $9}'`
         ip=`echo "$LINE" | awk '{print $11}'`
         data=`echo "$LINE" | awk '{print $2" "$1" "$3}'`
         proto=`echo "$LINE" | awk '{print $14}'`
mysql --host=$DB_HOST --user=$DB_USER --password=$DB_PASSWD $DB_NAME << EOF
INSERT INTO $TABLE (status, user, ip, data, protocol) VALUES ("$status", "$user", "$ip", "$data", "$proto");
EOF
      fi
   fi
done

#!/bin/bash

#Функция выбора статуса
choise_status(){
select i in acc fail
do
  break
done
}

choise_id(){
read -p "Enter id: " nt
return $nt
}

choise_ip(){
read -p "Enter ip: " nt
return $nt
}

choise_user(){
read -p "Enter user: " nt
return $nt
}

funstart() {
if [[ "$vegetable" == "status" ]]; then
       choise_status Accepted Failed
elif [[ "$vegetable" == "id" ]]; then
       choise_id
elif  [[ "$vegetable" == "ip" ]]; then
       choise_ip
elif [[ "$vegetable" == "user" ]]; then
       choise_user
else
       exit 0
fi
return $vegetable
}

PS3='Выберите ваш столбец в ДБ для поиска: '
choice_of() {
select vegetable
do
  echo
  break
done
}

choice_of status id ip user
funstart
#echo "funstart"

user="myshop_user"
db="mydb"
hst="192.168.100.214"
echo "$nt"

query="select id, status, user, ip, data from auth where $vegetable='$nt';"

OIFS="$IFS" ; IFS=$'\n' ; oset="$-" ; set -f

while IFS="$OIFS" read -a line
do
  echo ${line[0]} ${line[1]}  ${line[2]} ${line[3]} ${line[4]} ${line[5]}
done < <(mysql -h ${hst} -u${user} -p${pwd_db} ${db} -e "${query}")
exit 0

Добавление в базу mysql данных из Linux: /var/log/auth.log на bash
Скрипт работает на Nginx сервере и собирает статистику ip и login brutfors atack
 

Краткая инструкция как установить

1. check-ssh.sh - скрипт добавления в базу mysql
   mkdir /etc/script
   cp check-ssh.sh /etc/script/
2. checkssh.service  - systemd service
   cp checkssh.service /etc/systemd/system/
   1) добавить пароль от базы в env
      export DB_PASSWD="*****"
   2) daemon reload
      systemctl enable checkssh.service
      systemctl start checkssh.service
3. Создать ДБ удаленную или на localhost
   1) Изменить хост с ДБ в скрипте check-ssh.sh и select-fun.sh
   2) Сделать развертывание дампа
      mysql -uyour_username -h hostname -p name_your_db < dump.sql
   
4. Для проверки запускать скрипт с интерактивным меню select-fun.sh

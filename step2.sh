#!/bin/bash

echo "Проверим, что пользователи root, vagrant и otusadm есть в группе admin"
sudo cat /etc/group | grep admin
echo "Создадим файл-скрипт"
sudo cp /vagrant/login.sh /usr/local/bin/login.sh
echo "Добавим права на исполнение файла"
sudo chmod +x /usr/local/bin/login.sh
echo "Укажем в файле /etc/pam.d/sshd модуль pam_exec и наш скрипт"
echo "auth required pam_exec.so debug /usr/local/bin/login.sh" > /etc/pam.d/sshdtemp
cat /etc/pam.d/sshd >> /etc/pam.d/sshdtemp
sudo cp /etc/pam.d/sshd /etc/pam.d/sshd1
sudo cp /etc/pam.d/sshdtemp /etc/pam.d/sshd


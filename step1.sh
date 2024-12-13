#!/bin/bash

echo "Настроим ОС"
sudo apt update
sudo apt upgrade -y
sudo apt install -y mc

echo "Создаём пользователя otusadm и otus:"
sudo useradd otusadm && sudo useradd otus
echo "Создаём пользователям пароли"
echo -e "otusadm:Test!1" | sudo chpasswd
echo -e "otus:Test!1" | sudo chpasswd
echo "Создаём группу admin"
sudo groupadd -f admin
echo "Добавляем пользователей vagrant,root и otusadm в группу admin"
usermod otusadm -a -G admin && usermod root -a -G admin && usermod vagrant -a -G admin

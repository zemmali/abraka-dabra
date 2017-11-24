#!/bin/bash
###### 	Date 15/11/2017
######	Saddam ZEMMALI
######	Project abraka-dabra 
######	Task 	Install LAMP (MySQL8)

echo "Version: 1.0 ¯\_(ツ)_/¯"
echo "╔═══════════════════════════════════════╗"
echo "║- Author: Saddam ZEMMALI               ║"
echo "║- eMail:                               ║"
echo "║- Version: 1.0                         ║"
echo "╚═══════════════════════════════════════╝"


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	 Install PHP Repo User Guide [7]                    ║"
echo "╚═══════════════════════════════════════════════════════╝"
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install Apache/PHP User Guide                    ║"
echo "╚═══════════════════════════════════════════════════════╝"
yum install yum-utils
yum --enablerepo=remi,remi-php71 install httpd php php-common
yum-config-manager --enable remi-php71


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install Required PHP Modules                     ║"
echo "╚═══════════════════════════════════════════════════════╝"
yum --enablerepo=remi,remi-php71 install php-cli php-pear php-pdo php-mysqlnd php-pgsql php-gd php-mbstring php-mcrypt php-xml


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install Composer User Guide                      ║"
echo "╚═══════════════════════════════════════════════════════╝"
curl -sS https://getcomposer.org/installer | php

mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer 


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Manage Apache Service 		                        ║"
echo "╚═══════════════════════════════════════════════════════╝"
sudo systemctl start httpd.service 
sudo systemctl enable httpd.service
firewall-cmd --permanent --zone=public --add-port=80/tcp


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install MySQL 8.0/5.7		                        ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo "Enable MySQL Yum Repository"
rpm -Uvh https://repo.mysql.com/mysql57-community-release-el7-11.noarch.rpm

#echo "Install MySQL 5.7"
#yum install mysql-community-server 

echo "Install MySQL 8.0:"
yum --enablerepo=mysql80-community install mysql-community-server

echo "Find MySQL root Password"
grep "A temporary password" /var/log/mysqld.log

echo "Enable  MySQL Service Using Systemd"
systemctl enable mysqld.service

echo "Start MySQL Service Using SysVinit"
service mysqld start

echo "Start MySQL Service Using Systemd"
systemctl start mysqld.service

echo "Add New Rule to Firewalld"
firewall-cmd --permanent --zone=public --add-service=mysql

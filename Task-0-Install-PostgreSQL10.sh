#!/bin/bash
###### 	Date 15/11/2017
######	Saddam ZEMMALI
######	Project abraka-dabra 
######	Task 	Install PostgreSQL 10 + phpPgAdmin

echo "Version: 1.0 ¯\_(ツ)_/¯"
echo "╔═══════════════════════════════════════╗"
echo "║- Author: Saddam ZEMMALI               ║"
echo "║- eMail:                               ║"
echo "║- Version: 1.0                         ║"
echo "╚═══════════════════════════════════════╝"


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   PostgreSQL  User Guide [10]                      ║"
echo "╚═══════════════════════════════════════════════════════╝"

echo "Enable PostgreSQL Yum Repository"
yum -y localinstall https://yum.postgresql.org/10/redhat/rhel-7.5-x86_64/pgdg-redhat10-10-1.noarch.rpm

echo "Install PostgreSQL 10 Server"
yum -y install postgresql10-server postgresql10

echo "Initialize PGDATA"
/usr/pgsql-10/bin/postgresql-10-setup initdb

echo "Start PostgreSQL Server"
systemctl restart postgresql-10.service
systemctl enable postgresql-10.service


echo "Verify PostgreSQL Installation"
su - postgres -c "psql"

echo "create password for user postgres for security purpose."
#$ postgres=# \password postgres
echo "Add New Rule to Firewalld"
firewall-cmd --permanent --zone=public --add-port=5432/tcp


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	    phpPgAdmin User Guide [10]                      ║"
echo "╚═══════════════════════════════════════════════════════╝"
yum -y localinstall https://download.postgresql.org/pub/repos/yum/testing/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm

echo "Install phpPgAdmin using Yum"
yum install phpPgAdmin

echo "Configure phpPgAdmin to Access Remotly."
#Alias /phpPgAdmin /usr/share/phpPgAdmin
#
#<Directory /usr/share/phpPgAdmin>
#   order deny,allow
#   deny from all
#   allow from 192.168.1.0/24
#</Directory>

echo "Restart Apache Service"
systemctl restart httpd 

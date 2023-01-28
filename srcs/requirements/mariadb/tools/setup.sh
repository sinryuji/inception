#!/bin/sh

if [ ! -d "/var/lib/mysql/$MYSQL_DB" ]; then
	mysqld --bootstrap << EOF
use mysql;

flush privileges;

create database $MYSQL_DB;
create user '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';
grant all privileges on $MYSQL_DB.* to '$MYSQL_USER'@'%';

alter user '$MYSQL_ROOT'@'localhost' identified by '$MYSQL_ROOT_PASSWORD';

flush privileges;
EOF
fi

exec mysqld

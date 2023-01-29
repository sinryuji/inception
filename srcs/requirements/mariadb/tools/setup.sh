#!/bin/sh

if [ ! -d "/var/lib/mysql/$MYSQL_DB" ]; then
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  mysql_install_db --datadir=/var/lib/mysql --auth-root-authentication-method=normal >/dev/null
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

exec mysqld --datadir=/var/lib/mysql
# === --auth-root-authentication-method=normal ===
# 인증 메서드를 normal로 설정한다.
# ---
# 10.4버전 부터 인증에 unix_socket 방식을 사용한다.
# 10.3버전을 사용해 문제는 없겠지만 명시적 선언했다.

# === --datadir ===
# 데이터 베이스의 루트 디렉토리 경로

# === mysqld --bootstrap ===
# Used by mysql installation scripts : mysql 설치 스크립트에 사용되는 옵션
# mysql --bootstrap < mysql.txt
# mysql --botstratp <<EOF [...] EOF

# === grant table ===
# 사용자 계정과 사용자 계정 권한이 포함된 여러 테이블을 포함하는 grant table이 있다.

# === mysql_install_db ===
# 새로운 grant table 생성, 기존 다른 grant table과 데이터에 영향을 주지 않는다.

# === flush privileges ===
# grant table을 flush함으로써 변경 사항을 즉시 반영한다(읽어 온다).

# === alter ===
# RDBMS에서 이미 존재하는 개체의 속성을 변경할 때 사용하는 키워드

# === create user ===
# username@% // %는 외부의 접근을 허용한다는 의미
# username@10.0.2.14 // 10.0.2.14에 대해서만 접근을 허용

# === 유저에게 데이터 베이스의 접근 권한 부여 ===
# grant all privileges on '[db_name.table_name]' to '[user@host(ip)]' identified by 'password' [grant options];
# grant all previleges on ~ to ~;

# === 유저 접근 권한 부여 취소 ===
# revoke select, insert, delete, update on [table_name] from [user_name] ;

# === mysql / mysqld ===
# mysql : command line client
# mysqld : server executable

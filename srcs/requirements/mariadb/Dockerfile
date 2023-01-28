FROM debian:buster

EXPOSE 3306

COPY ./tools/setup.sh /setup.sh

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get	install -y mariadb-server mariadb-client && \
	mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	sed -i "s/bind-address/# bind-address/" /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["sh", "/setup.sh"]

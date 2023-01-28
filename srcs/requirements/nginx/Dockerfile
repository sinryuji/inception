FROM debian:buster

EXPOSE 443
EXPOSE 80

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y nginx openssl && \
	mkdir -p /etc/ssl && \
	openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
	    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Kim/CN=hyeongki.42.fr" \
	    -keyout "/etc/ssl/hyeongki.42.fr.key" \
	    -out "/etc/ssl/hyeongki.42.fr.crt" 
# 2>/dev/null

COPY conf/default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]

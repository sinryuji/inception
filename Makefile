DB_DATA_DIR = /home/hyeongki/data/mariadb
APP_DATA_DIR = /home/hyeongki/data/wordpress
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
DOCKER_COMPOSE = docker compose --file $(DOCKER_COMPOSE_FILE)

# CMD

all: up

up:
		mkdir -p $(DB_DATA_DIR) $(APP_DATA_DIR)
		$(DOCKER_COMPOSE) up --build

down:
		$(DOCKER_COMPOSE) down --volumes

clean:
		$(DOCKER_COMPOSE) down --rmi all --volumes
		sudo rm -rf $(DB_DATA_DIR) $(APP_DATA_DIR)

fclean: clean
		docker container prune --force
		docker image prune -a --force
		docker network prune --force
		docker volume prune --force
		docker system prune --force

re:
		make fclean
		make all	

.PHONY:	all up down clean fclean re

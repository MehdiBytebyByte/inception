NAME = inception
SRCS = ./srcs
COMPOSE_FILE = $(SRCS)/docker-compose.yml
DATA_PATH_DB = /home/mboughra/mariadb
DATA_PATH_WP = /home/mboughra/wordpress

all:
	mkdir -p $(DATA_PATH_DB)
	mkdir -p $(DATA_PATH_WP)
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

stop:
	docker compose -f $(COMPOSE_FILE) stop

start:
	docker compose -f $(COMPOSE_FILE) start

clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all -v

fclean: clean
	sudo rm -rf $(DATA_PATH_DB)/*
	sudo rm -rf $(DATA_PATH_WP)/*
	docker system prune -af

re: fclean all

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

# .PHONY: all down stop start clean fclean re logs
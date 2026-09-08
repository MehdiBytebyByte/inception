# ============================================================================
#  ft_inception — Makefile
# ----------------------------------------------------------------------------
#  Targets mirror the 42 subject: all, build, down, clean, fclean, re, logs
#
#  Data is persisted in bind volumes on the HOST. The default paths below
#  match the author's login (mboughra). On your own machine, override them
#  without editing the file:
#
#      make DATA_PATH_DB=$HOME/data/mariadb DATA_PATH_WP=$HOME/data/wordpress all
#
#  NOTE: `docker-compose.yml` hardcodes the same host paths in its volume
#  definitions, so if you change them here you MUST update the compose file
#  too (see the `device:` entries).
# ============================================================================

NAME         = inception
SRCS         = ./srcs
COMPOSE_FILE = $(SRCS)/docker-compose.yml

# Host directories that back the Docker volumes (edit these to match your login)
DATA_PATH_DB = /home/mboughra/mariadb
DATA_PATH_WP = /home/mboughra/wordpress

# ----------------------------------------------------------------------------
.PHONY: all build up down stop start clean fclean re logs ps

# Build images and start the stack in detached mode
all: build up

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	mkdir -p $(DATA_PATH_DB)
	mkdir -p $(DATA_PATH_WP)
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

stop:
	docker compose -f $(COMPOSE_FILE) stop

start:
	docker compose -f $(COMPOSE_FILE) start

# Remove containers, images and named volumes (keeps host data dirs)
clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all -v

# Full cleanup: also delete persisted data and prune Docker
fclean: clean
	sudo rm -rf $(DATA_PATH_DB)/*
	sudo rm -rf $(DATA_PATH_WP)/*
	docker system prune -af

# Rebuild from scratch
re: fclean all

# Stream logs from all services
logs:
	docker compose -f $(COMPOSE_FILE) logs -f

# Show running containers
ps:
	docker compose -f $(COMPOSE_FILE) ps
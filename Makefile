COMPOSE = ./srcs/docker-compose.yml

all:
	@echo "Starting all containers..."
	@mkdir -p /home/mthiry/data/wordpress
	@mkdir -p /home/mthiry/data/mariadb
	@sudo docker-compose -f $(COMPOSE) up -d --build
	@echo "All containers started successfully!"

down:
	@echo "Stopping all containers..."
	@sudo docker-compose -f $(COMPOSE) down
	@echo "All containers stopped successfully!"

re: down clean all
	
clean:
	@echo "Cleaning up containers, images, networks and volumes..."
	-@if [ "$$(sudo docker ps -q)" ]; then \
		sudo docker stop $$(sudo docker ps -aq); \
		sudo docker rm $$(sudo docker ps -aq); \
		echo "Containers removed successfully!"; \
	else \
		echo "No containers to remove"; \
	fi
	-@if [ "$$(sudo docker images -q)" ]; then \
		sudo docker rmi $$(sudo docker images -q); \
		echo "Images removed successfully"; \
	else \
		echo "No images to remove"; \
	fi
	-@if [ "$$(sudo docker network ls --filter "name=^(?!(bridge|host|none)$).*" -q)" ]; then \
		sudo docker network rm $$(sudo docker network ls --filter "name=^(?!(bridge|host|none)$).*" -q); \
		echo "Networks removed successfully!"; \
	else \
		echo "No networks to remove"; \
	fi
	-@if [ "$$(sudo docker volume ls -q)" ]; then \
		sudo docker volume rm $$(sudo docker volume ls -q); \
		echo "Volumes removed successfully!"; \
	else \
		echo "No volumes to remove"; \
	fi

save:
	git commit -am "$(MAKECMDGOALS)";
	git push https://github.com/swautelet/inception;

.PHONY: all re down clean save

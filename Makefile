platform:
	@docker-compose up -d zookeeper kafka schema-registry reverse-proxy

stop:
	@docker-compose down

stop-data:
	@docker-compose rm -s -f kafka-create-topics kafka-music-data-generator

topics:
	@docker-compose up -d kafka-create-topics

status:
	@docker-compose ps

list-topics:
	@docker-compose exec kafka kafka-topics --zookeeper zookeeper:32181 --list

content:
	@docker-compose up -d kafka-music-data-generator

show-content:
	@docker-compose exec schema-registry kafka-avro-console-consumer --bootstrap-server kafka:29092 --topic $(topic) --from-beginning

app:
	@docker-compose up --no-deps --scale kafka-music-application=2 -d kafka-music-application

stop-app:
	@docker-compose rm -s -f kafka-music-application

instances:
	@curl -sXGET -H Host:music.docker.localhost -w "\n" http://localhost:9080/kafka-music/instances

top-five:
	# local or remote
	@curl -sXGET -H Host:music.docker.localhost -w "\n" http://localhost:9080/kafka-music/charts/top-five

genre:
	# local or remote
	@curl -sXGET -H Host:music.docker.localhost -w "\n" http://localhost:9080/kafka-music/charts/genre/Pop

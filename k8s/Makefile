stop: stop-content stop-app stop-schema-registry stop-kafka stop-zk

zk:
	kubectl apply -f zookeeper-service.yaml,zookeeper-deployment.yaml

stop-zk:
	kubectl delete --ignore-not-found=true -f  zookeeper-service.yaml,zookeeper-deployment.yaml

kafka:
	kubectl apply -f  kafka-service.yaml,kafka-deployment.yaml

stop-kafka:
	kubectl delete --ignore-not-found=true  -f  kafka-service.yaml,kafka-deployment.yaml

schema-registry:
	kubectl apply -f  schema-registry-service.yaml,schema-registry-deployment.yaml

stop-schema-registry:
	kubectl delete --ignore-not-found=true -f  schema-registry-service.yaml,schema-registry-deployment.yaml

create-topics:
	kubectl exec -it deployment/kafka -- kafka-topics --create --topic play-events --if-not-exists --zookeeper zookeeper:32181 --partitions 4 --replication-factor 1
	kubectl exec -it deployment/kafka -- kafka-topics --create --topic song-feed --if-not-exists --zookeeper zookeeper:32181 --partitions 4 --replication-factor 1

list-topics:
	kubectl exec -it deployment/kafka -- kafka-topics --zookeeper zookeeper:32181 --list

status:
	kubectl get all

content:
	kubectl run feed --image=confluentinc/kafka-streams-examples:5.5.0 --command -- java -cp /usr/share/java/kafka-streams-examples/kafka-streams-examples-5.5.0-standalone.jar io.confluent.examples.streams.interactivequeries.kafkamusic.KafkaMusicExampleDriver kafkasvc:29092 http://schema-registrysvc:8081

stop-content:
	kubectl delete --ignore-not-found=true deployment feed

show-content:
	kubectl exec -it deployment/schema-registry -- kafka-avro-console-consumer --bootstrap-server kafkasvc:29092 --topic $(topic) --from-beginning

scale-app:
	kubectl scale --replicas=$(replicas) deployment/kafka-music-application

app:
	kubectl apply -f  kafka-music-application-service.yaml,kafka-music-application-deployment.yaml

stop-app:
	kubectl delete --ignore-not-found=true -f  kafka-music-application-service.yaml,kafka-music-application-deployment.yaml

instances:
	@curl -sXGET -w "\n" http://localhost:7070/kafka-music/instances

# local or remote
top-five:
	@curl -sXGET -w "\n" http://localhost:7070/kafka-music/charts/top-five

# local or remote
genre:
	@curl -sXGET -w "\n" http://localhost:7070/kafka-music/charts/genre/Pop

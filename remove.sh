docker stop notificacao blue green clientes && docker rm notificacao blue green clientes 
docker-compose stop && docker-compose rm -f && docker volume prune -f && git pull
docker volume rm apigateway_kong-datastore apigateway_keycloak-datastore

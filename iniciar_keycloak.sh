docker-compose up -d keycloak-db
docker-compose ps

docker-compose up -d keycloak
docker-compose ps

docker exec -it keycloak keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin
docker exec -it keycloak keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE

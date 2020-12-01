#!/bin/bash
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8180)" != "200" ]]; do echo .; sleep 5; done'
echo "Keycloak is up"

docker-compose exec keycloak keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
docker-compose exec keycloak keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE --user admin --password admin

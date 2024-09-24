#!/bin/bash
echo ""
echo "Configurando o Keycloak:"
echo ""
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8180/admin/master/console/)" != "200" ]]; do printf "."; sleep 3; done'
echo ""
echo "Keycloak is up"

docker-compose exec keycloak opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin
docker-compose exec keycloak opt/keycloak/bin/kcadm.sh get realms --fields id,realm,enabled
docker-compose exec keycloak opt/keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE --user admin --password admin

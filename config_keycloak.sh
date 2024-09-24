#!/bin/bash
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8180/admin/master/console/)" != "200" ]]; do echo .; sleep 5; done'
echo "Keycloak is up"

export PASSWORD=admin
docker-compose exec keycloak opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password $PASSWORD
docker-compose exec keycloak opt/keycloak/bin/kcadm.sh get realms --fields id,realm,enabled
docker-compose exec keycloak opt/keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE --user admin --password admin

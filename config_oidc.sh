#!/bin/bash
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8180)" != "302" ]]; do echo .; sleep 5; done'
echo "Keycloak is up"

HOST_IP=$(curl checkip.amazonaws.com)
echo $HOST_IP

# CLIENT_SECRET=<client_secret_from_keycloak>
echo "Digite o secret do Kong:"
read CLIENT_SECRET

curl -s -X POST http://localhost:8001/plugins \
  -d name=oidc \
  -d config.client_id=kong \
  -d config.client_secret=${CLIENT_SECRET} \
  -d config.discovery=http://${HOST_IP}:8180/auth/realms/master/.well-known/openid-configuration \
  | python -mjson.tool

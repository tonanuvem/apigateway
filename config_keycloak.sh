docker-compose exec keycloak keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin
docker-compose exec keycloak keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE

HOST_IP=$(curl checkip.amazonaws.com)
echo $HOST_IP

# CLIENT_SECRET=<client_secret_from_keycloak>
echo "Digite o secret do kong"
read CLIENT_SECRET

curl -s -X POST http://localhost:8001/plugins \
  -d name=oidc \
  -d config.client_id=kong \
  -d config.client_secret=${CLIENT_SECRET} \
  -d config.discovery=http://${HOST_IP}:8180/auth/realms/master/.well-known/openid-configuration \
  | python -mjson.tool
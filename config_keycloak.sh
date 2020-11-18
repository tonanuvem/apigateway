while [[ "$$(curl --connect-timeout 2 -s -o /dev/null -w ''%{http_code}'' http://localhost:8180)" != "200" ]]; do 
  echo . 
  sleep 5
done 
echo "Keycloak is up"

# docker-compose exec keycloak keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
# docker-compose exec keycloak keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE --user admin --password admin

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

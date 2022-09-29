docker-compose up -d keycloak-db
docker-compose ps

docker-compose up -d keycloak
docker-compose ps
echo ""
echo "Config OK"
echo ""
IP=$(curl -s checkip.amazonaws.com)
echo ""
echo "URLs do projeto:"
echo ""
echo " - KeyCloak        : http://$IP:8180"
echo ""

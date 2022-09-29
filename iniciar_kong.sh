docker-compose up -d kong-db
docker-compose up -d kong-migration
docker-compose up -d kong
docker-compose up -d konga
docker-compose ps
echo ""
echo "Config OK"
echo ""
IP=$(curl -s checkip.amazonaws.com)
echo ""
echo "URLs do projeto:"
echo ""
echo " - KONGA        : http://$IP:31337"
echo ""

docker-compose up -d kong-db
docker-compose ps

docker-compose run --rm kong kong migrations up

docker-compose up -d kong
docker-compose ps

curl -s -X POST http://localhost:8001/services -d name=mock-service -d url=http://mockbin.org/request
curl -s -X POST http://localhost:8001/routes -d service.id=${service_id} -d paths[]=/mock

curl -s http://localhost:8000/mock

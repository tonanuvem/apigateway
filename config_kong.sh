while [[ "$$(curl --connect-timeout 2 -s -o /dev/null -w ''%{http_code}'' http://localhost:8001)" != "200" ]]; do 
  echo . 
  sleep 5
done 
echo "Kong is up"

curl -s -X POST http://localhost:8001/services -d name=mockbin -d url=http://mockbin.org/request
curl -s -X POST http://localhost:8001/services/mockbin/routes -d paths[]=/mock

curl -s http://localhost:8000/mock

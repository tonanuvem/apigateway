IP=$(curl checkip.amazonaws.com)
curl -i -X POST --url http://localhost:8001/services/ --data 'name=clientes' --data "url=http://$IP:5000/api/clientes"
curl -i -X POST --url http://localhost:8001/services/clientes/routes --data 'paths[]=/clientes'

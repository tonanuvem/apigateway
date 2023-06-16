docker run --name blue -p 8081:80 -d tonanuvem/fiap_page:blue
docker run --name green -p 8082:80 -d tonanuvem/fiap_page:green

## BLUE GREEN
curl -X POST http://localhost:8001/services/ --data "name=bluegreen-aluno" --data "url=http://$IP:8081"
curl -i -X POST --url http://localhost:8001/services/bluegreen-aluno/routes --data "hosts[]=aluno.$IP.sslip.io"
curl -X POST http://localhost:8001/services/ --data "name=bluegreen-prof" --data "url=http://$IP:8082"
curl -i -X POST --url http://localhost:8001/services/bluegreen-prof/routes --data "hosts[]=prof.$IP.sslip.io"
IP=$(curl checkip.amazonaws.com) 

## CANARY
curl -X POST http://localhost:8001/services/ --data "name=notificacao-canary" --data "host=notificacao.upstream"
curl -i -X POST --url http://localhost:8001/services/notificacao-canary/routes --data 'paths[]=/notificacao/canary'
curl -X POST http://localhost:8001/upstreams --data 'name=notificacao.upstream'
curl -X POST http://localhost:8001/upstreams/notificacao.upstream/targets --data "target=$IP:8081" --data "weight=70" 
curl -X POST http://localhost:8001/upstreams/notificacao.upstream/targets --data "target=$IP:8082" --data "weight=30" 

## URLs:
sh bluegreen.sh
sh canary.sh

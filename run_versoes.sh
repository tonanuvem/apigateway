docker run --name login -p 8070:80 -d tonanuvem/login
docker run --name blue -p 8081:80 -d tonanuvem/fiap_page:blue
docker run --name green -p 8082:80 -d tonanuvem/fiap_page:green

IP=$(curl checkip.amazonaws.com) 

## BLUE GREEN
# LOGIN
curl -X POST http://localhost:8001/services/ --data "name=bluegreen-login" --data "url=http://$IP:8070"
curl -i -X POST --url http://localhost:8001/services/bluegreen-login/routes --data "hosts[]=$IP.sslip.io"
# BLUE
curl -X POST http://localhost:8001/services/ --data "name=bluegreen-aluno" --data "url=http://$IP:8081"
curl -i -X POST --url http://localhost:8001/services/bluegreen-aluno/routes --data "hosts[]=aluno.$IP.sslip.io"
#  GREEN
curl -X POST http://localhost:8001/services/ --data "name=bluegreen-prof" --data "url=http://$IP:8082"
curl -i -X POST --url http://localhost:8001/services/bluegreen-prof/routes --data "hosts[]=prof.$IP.sslip.io"


## CANARY
curl -X POST http://localhost:8001/services/ --data "name=notificacao-canary" --data "host=notificacao.upstream"
curl -i -X POST --url http://localhost:8001/services/notificacao-canary/routes --data 'paths[]=/notificacao/canary'
curl -X POST http://localhost:8001/upstreams --data 'name=notificacao.upstream'
curl -X POST http://localhost:8001/upstreams/notificacao.upstream/targets --data "target=$IP:8081" --data "weight=70" 
curl -X POST http://localhost:8001/upstreams/notificacao.upstream/targets --data "target=$IP:8082" --data "weight=30" 

## URLs:
sh bluegreen.sh
sh canary.sh

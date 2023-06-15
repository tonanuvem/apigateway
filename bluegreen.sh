#curl -X POST http://localhost:8001/services/ --data "name=bluegreen-aluno" --data "url=http://$IP:8081"
#curl -i -X POST --url http://localhost:8001/services/bluegreen-aluno/routes --data "hosts[]=aluno.$IP.nip.io"

#curl -X POST http://localhost:8001/services/ --data "name=bluegreen-prof" --data "url=http://$IP:8082"
#curl -i -X POST --url http://localhost:8001/services/bluegreen-prof/routes --data "hosts[]=prof.$IP.nip.io"

IP=$(curl checkip.amazonaws.com) 
echo "URLs do projeto:"
echo ""
echo " - ALUNO (BLUE)        : http://aluno.$IP.nip.io:8000"
echo ""
echo ""
echo " - PROF  (GREEN)       : http://aluno.$IP.nip.io:8000"
echo ""

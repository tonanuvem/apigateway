IP=$(curl -s checkip.amazonaws.com) 
echo "URLs do projeto:"
echo ""
echo " - LOGIN  (BLUE/GREEN)   : http://$IP.sslip.io:8000"
echo ""
echo ""
# echo "Observação, a página de Login direciona para as URLs abaixo:"
#echo ""
#echo " - ALUNO (BLUE)        : http://aluno.$IP.sslip.io:8000"
#echo ""
#echo ""
#echo " - PROF  (GREEN)       : http://prof.$IP.sslip.io:8000"
#echo ""

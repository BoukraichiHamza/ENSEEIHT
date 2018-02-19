
pour lancer la BD
- cd bd
- ant start
- and db
- voir readme.txt dans bd pour avoir un shell SQL 

pour lancer l'appli web et le web service
- tomcat/bin/startup.sh
- pour les 2 appli utilisant Tomcat (web et WS) le war est deja dans webapps

URL à utiliser :
http://localhost:8080/web/Serv
WSDL a utiliser : http://localhost:8080/WS/services/AccountManager?wsdl


WS affiche des comptes créés dans /tmp/accounts

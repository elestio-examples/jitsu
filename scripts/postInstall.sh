#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready

docker-compose down;
sed -i "s~DOMAIN_TO_CHANGE~${DOMAIN}~g" ./docker-compose.yml
docker-compose up -d;

echo "Waiting for software to be ready ..."
sleep 30s;
#!/bin/sh
apt-get remove -y docker docker-engine docker.io
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce
FILE="/etc/docker/daemon.json"
/bin/cat <<EOM >$FILE
{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}
EOM
sudo service docker restart
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
cd ..
sudo chmod 777 ./grafana/setup.sh
sudo docker-compose up --build &
read -p "Press enter to Exit"

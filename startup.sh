#! /bin/bash
export DOCKER_HOST_IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
sleep 2
cd /home/bio/biomaj/biomaj-watcher
sed -i -e 's@mongodb://localhost/biomaj_celery@mongodb://'$DOCKER_HOST_IP'/biomaj_celery@g' development.ini
cd /home/bio/biomaj
sed -i -e 's@mongodb://localhost:27017@mongodb://'$DOCKER_HOST_IP':27017@g' global.properties
mongod --bind_ip $DOCKER_HOST_IP &
sleep 60
mongo --port 27017 --host $DOCKER_HOST_IP < /home/bio/biomaj/mongocommands &
sleep 2
cd /home/bio/biomaj/biomaj/bin
python biomaj-cli.py --config /home/bio/biomaj/global.properties &
cd /home/bio/biomaj/biomaj-watcher/db
python seed.py --config /home/bio/biomaj/global.properties --user bio --pwd maj &
cd /home/bio/biomaj/biomaj-watcher
su -c  'pserve development.ini' -s /bin/bash bio &
su -c  'pceleryd development.ini' -s /bin/bash bio &
wait

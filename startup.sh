#! /bin/bash
cd /home/bio/biomaj/biomaj-watcher
sed -i -e 's@mongodb://localhost/biomaj_celery@mongodb://'$MONGO_PORT_27017_TCP_ADDR':'$MONGO_PORT_27017_TCP_PORT'/biomaj_celery@g' development.ini
cd /home/bio/biomaj
sed -i -e 's@mongodb://localhost:27017@mongodb://'$MONGO_PORT_27017_TCP_ADDR':'$MONGO_PORT_27017_TCP_PORT'@g' global.properties
cd /home/bio/biomaj/biomaj/bin
python biomaj-cli.py --config /home/bio/biomaj/global.properties &
cd /home/bio/biomaj/biomaj-watcher/db
sleep 20
python seed.py --config /home/bio/biomaj/global.properties --user bio --pwd maj &
cd /home/bio/biomaj/biomaj-watcher
su -c  'pserve development.ini' -s /bin/bash bio &
su -c  'pceleryd development.ini' -s /bin/bash bio &
wait

#run with the following command: docker run -d -p :27017 --volumes-from data_container --name mongodb mongodb_$BUILD_ID
#default username: bio
#default password: maj

#start from ubuntu, of course
FROM ubuntu

#make a new user, call the user bio
RUN adduser --disabled-password bio
RUN adduser bio sudo

#install some dependencies
RUN echo "deb http://archive.ubuntu.com/ubuntu/ vivid universe" | sudo tee -a "/etc/apt/sources.list"
RUN apt-get update && apt-get install -y \
	git \
	libcurl4-openssl-dev \
	gcc \
	build-essential \
	python-setuptools \
	python-dev \
	python-pip \
	libssl-dev \
	npm \
	default-jre \
	default-jdk \
	wget

#install pip
RUN easy_install pip

#copy the files over
RUN cd /home/bio/ && mkdir biomaj && cd biomaj && git clone https://github.com/genouest/biomaj.git && git clone https://github.com/genouest/biomaj-watcher.git
ADD ./global.properties /home/bio/biomaj/global.properties
ADD ./bower_components /home/bio/biomaj/biomaj-watcher/biomajwatcher/webapp/app/bower_components
ADD ./startup.sh /usr/bin/startup
RUN chmod +x /usr/bin/startup
ADD ./mongocommands /home/bio/biomaj/
ADD ./requirements.txt /home/bio/biomaj/biomaj/requirements.txt

#install a repo for curl and install curl:
RUN sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install curl

#install updated copy of nodejs and build-essential just in case
RUN curl sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get install build-essential

#install up-to-date setuptools because ubuntu servers' copy is old
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python

#install biomaj
RUN cd /home/bio/biomaj/biomaj && python setup.py install
RUN cd /home/bio/biomaj/biomaj-watcher && python setup.py develop
RUN cd /home/bio/biomaj/ && mkdir etc && mkdir log && mkdir process && mkdir cache && mkdir banks
RUN cd /home/bio/ && chown -R bio biomaj

#add config file
ADD ./development.ini /home/bio/biomaj/biomaj-watcher/development.ini 

#run the startup and begin
CMD ["/usr/bin/startup"]

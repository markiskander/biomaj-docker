# biomaj-docker
A suite containing biomaj, biomaj-watcher, and all of their dependencies in two docker containers, one for biomaj, and one for the database side of things. Just build, launch, and connect to the IP specified in the console in your browser. This docker exclusively uses the developer.ini method of connecting to BioMAJ.

# Setting up
First you need to install docker. Simply follow the instructions for your OS here: https://docs.docker.com/installation/

Next, make sure docker isn't running:

    sudo pkill docker

Then run this command to specify which DNS for docker to use (important for this build):

    sudo docker -d --dns=*your dns here*
    
Next, we need to get the latest Ubuntu base image from docker. In another terminal instance, run:

    docker pull ubuntu
    
Next, we need to install Docker-Compose. To do so, run:

    sudo pip install -U docker-compose

Next up, clone this git into a folder (referring to this specific branch, using -b), cd into it, and simply run 

    sudo docker-compose build

The build can take anywhere from 10-25 minutes (lots of packages to fetch from various repos, so it depends greatly on your computer and internet speeds.)

# Running biomaj-docker (docker-compose version)
To run this package, simply use the following command: 

    sudo docker-compose up

Startup takes significantly less time than the standard biomaj-docker method (without docker-compose). There is only an artificial delay of 10 seconds in the startup. Once the console specifies an IP that you can connect to, the server should be up and running and accessible through your web browser. Use port 6543 in order to launch the site.

To close biomaj-docker, simply close the terminal instance (this kills the process) or CTRL-C it.

# Default credentials
By default, this docker uses **bio** as default username and **maj** as default password. This can be changed in *startup.sh* on line 10.

# Potential issues
If there are any changes made to biomaj and/or biomaj-watcher by their maintainers, back up your files and simply rebuild the docker; the Dockerfile always pulls the latest available copy of biomaj and biomaj-watcher from their git repos.

# biomaj-docker
A suite containing biomaj, biomaj-watcher, and all of their dependencies in a docker. Just build, launch, and connect to the IP specified in the console in your browser. This docker exclusively uses the developer.ini method of connecting to BioMAJ.

# Setting up
First you need to install docker. Simply follow the instructions for your OS here: https://docs.docker.com/installation/

Next, make sure docker isn't running:

    sudo pkill docker

Then run this command to specify which DNS for docker to use (important for this build):

    sudo docker -d --dns=*your dns here*
    
Next, we need to get the latest Ubuntu base image from docker. In another terminal instance, run:

    docker pull ubuntu

Next up, clone this git into a folder, cd into it, and simply run 

    sudo docker build --no-cache -t biomaj-docker .

The build can take anywhere from 15-25 minutes (lots of packages to fetch from various repos).

# Running
To run this package, simply use the following command: 

    sudo docker run biomaj-docker

Startup takes about one minute (artificial delays enforced in order to make sure the service is running before we try to access the database)

After a minute, BioMAJ Watcher should be up and running. Simply enter the IP specified in the console with a port of 6543 in order to launch the site.

To close biomaj-docker, simply close the terminal instance (this kills the process)

# Default credentials
By default, this docker uses **bio** as default username and **maj** as default password. This can be changed in *startup.sh* on line 15.

# Potential issues
If upon running the docker, you get a mongo connection refused error, it might be because mongod is taking long to start up. the startup file has a 60 second wait by default to make sure mongod starts. On some machines this may not be sufficient. If so, simply edit the line "sleep 60" to "sleep 90" or so in startup.sh in your biomaj-docker folder.

On the other hand, if you have a faster machine, mongod might finish within seconds. In that case, you can modify the startup.sh to lessen the wait.

If there are any changes made to biomaj and/or biomaj-watcher by their maintainers, back up your files and simply rebuild the docker; the Dockerfile always pulls the latest available copy of biomaj and biomaj-watcher from their git repos.

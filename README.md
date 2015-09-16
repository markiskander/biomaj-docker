# biomaj-docker
A suite containing biomaj, biomaj-watcher, and all of their dependencies in a docker. Just build, launch, and connect to the IP specified in the console in your browser.

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

# Default credentials
By default, this docker uses **bio** as default username and **maj** as default password. This can be changed in *startup.sh* on line 15.

# Potential issues
If upon running the docker, you get a mongo connection refused error, it might be because mongod is taking long to start up. the startup file has a 60 second wait by default to make sure mongod starts. On some machines this may not be sufficient. If so, simply edit the line "sleep 60" to "sleep 90" or so in startup.sh in your biomaj-docker folder.

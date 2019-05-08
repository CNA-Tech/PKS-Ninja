# Docker-Lab
In this lab you will learn some basic commands of Docker to help you understand how to operate Docker as a building block of Kubernetes.  

[Getting Started with Docker](#getting-started-with-docker)  
[Docker Networking](#docker-networking)  
[Docker Image Creation](#docker-image-creation)  
[Clean up and Wordpress](#clean-up-and-wordpress)  
[Challenge Activity](#challenge-activity)  

## Getting Started with Docker

IP addresses in this tutorial will change in your environment and you may have to put your correct IP address into the commands for them to work.

Start by opening putty and logging into the the cli-vm. Use `root` user. There is no password.

Let's clone a repository that will contain all the code for your labs

    cd

    git clone https://github.com/gortee/PKS-Lab

You can browse the the reposity by changing into the directory or by visiting the site.  (`cd PKS-Lab`)

Let's start with a simple container from docker hub (https://hub.docker.com/) 

Run the following command:

    docker run -dit --name my_container alpine ash

![DockerOutput](https://github.com/gortee/pictures/blob/master/D1.png)

This will start a container called my_container running the alpine image with it's shell ash started.  Let's examine the command line:

`-dit : d=detached i=interactive t=tty  this allows us to run commands in the container`

`--name : name of container for easy reference`

`alpine : image name from docker hub if not found locally https://hub.docker.com/_/alpine`

 `ash : paramter to tell it to start the ash shell which gives us the potential of interactivity`

We can see it as running and get it's container ID with the following command

    docker ps

![DockerOutput](https://github.com/gortee/pictures/blob/master/D2.PNG)

Now it's execute a ping inside this container.

    docker exec -it my_container ping -w3 google.com 
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D3.PNG)

Let's examine this command line:

`-it : i=interactive t=tty this allows us to run commands in the container`

`my_container : user friendly name`

`ping -w3 google.com : send three pings to google.com`

Notice is has output from the ping is to standard out in otherwords outside the container.  This is a key element of 12 factor applications that logging and error should go to standard out.   Having some method to capture this output is critical or it's lost.  12 factor applications should always log to stardard out (console).   

Let's review the network settings for our containers.  
   
    docker network ls
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D4.PNG)

The output shows that we have four networks total each of these networks represents it's own routing domain.  Every container inside a specific network ID has the ability to communicate with each other.   The capability for a container to get outside it's own network is done via source NAT.  You can expose specific container ports on the docker host for external service exposure.   Lets examine the networking for my_container look specifically for the NetworkSettings section

    docker inspect my_container
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D5.PNG)

As you can see the container has an assigned IP address with a gateway you should be able to ping this container from your docker host but not the outside world.  Trying pinging the container from your docker host looking for the IPAddress line (mine is 172.17.0.2)

    ping 172.17.0.2
    
You can end your ping with CTRL-C

![DockerOutput](https://github.com/gortee/pictures/blob/master/D6.PNG)

With containers you are able to start and stop them.   Let's try stopping my_container:

    docker stop my_container
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D15.PNG)

Let's see the status of my_container

    docker ps
 
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D16.PNG)
 
 As you can see my_container is not running.   It is still available and if I tried to create another container called my_container it would fail because it's just not currently running.  You can see all containers with this command:
 
     docker ps -a
     
  ![DockerOutput](https://github.com/gortee/pictures/blob/master/D17.PNG)
  
You can restart the container with `docker start my_container` or remove it completely with `docker rm container_id`  in my case I want it running again:

    docker start my_container
    
  ![DockerOutput](https://github.com/gortee/pictures/blob/master/D18.PNG)

Let's now create a web server container that forwards container port 80 to docker host port 8080 (making port 80 on the container accessable on the real network)  For this we will use a ngnix container.  

    docker run -d -p 8080:80 --name my_web_server nginx
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D7.PNG)

Lets examine this command line

`run : run a container`

`-d : detached`

`-p 8080:80 : expose port 80 on the container via port 8080 on the docker host`

`--name my_web_server : user friendly name of container`

`nginx : docker hub image to use`

Go to the browser and type in the URL: `CLI-VM:8080` to see if nginx is working.

By default both of these containers are connected to the bridge docker network.   (Docker creates three networks when started: bridge, host, none)  Everything inside a network is able to communicate with each other and the host is able to communicate with all.   

Let's inspect the bridge network to understand the containers IP addresses

    docker network inspect bridge
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D8.PNG)

You can see that my_web_server and my_container both have ip addresses in 172.17.0.0/16 (or some other address randomly assigned by your system)

## Docker-Networking
A user defined network has the following characteristics that the default bridge network (bridge) does not have:
 - Containers on the same bridge automatically expose all ports to each other and no ports to outside world
 - Containers on the same bridge can access each other by IP or name/alias
 - Containers can connect and disconnect from user-defined networks on the fly while running
 - Each user defined network has it's own bridge network that can be configured 
 
Let's create a new network for some containers by creating a user defined bridge

    docker network create dev_network
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D9.PNG)

We can list currently created networks with 

    docker network ls
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D10.PNG)

As shown we have now created a new network for docker.   When you create a new network you create a new bridge.   All containers on the same bridge automatically expose all ports to each other and no ports to the outside world.   Let's look at the details and compare the bridge and dev_netwoks:

    docker network inspect bridge
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D11.PNG)

Notice that the default bridge has a subnet of 172.17.0.0/16 (your may be different) and lots of configurable settings.  

Examine dev_network

    docker network inspect dev_network
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D12.PNG)

Notice a few differences with the output first it's a different randomly assigned network (172.21.0.0/16 in my case) and it has a default gateway assigned.  

Let's test some of the properties of our dev_network by deploying some containers to it:

    docker run -dit --name ping1 --network dev_network alpine ash
    docker run -dit --name ping2 --network dev_network alpine ash

![DockerOutput](https://github.com/gortee/pictures/blob/master/D13.PNG)

Let's examine the dev_network in detail

    docker network inspect dev_network
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D14.PNG)

As you can see we now have two containers attached to the dev_network ping1(172.21.0.2/16) & ping2(172.21.0.3/16) Let's test communication between the containers.  Let's attach to the console one ping1 (which is possible because it's running the ash shell) keep in mind that in order to detach from the console you will want to use CTRL-P+CTRL-Q (failure to do this control sequence will terminate the container). To pass this, you have to use the virtual keyboard. Go to start button (Windows), and search for `on-screen` and it will bring up the virtual keyboard.

    docker container attach ping1
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D19.PNG)

Let's try to ping the second container by name 

    ping -c 3 ping2

![DockerOutput](https://github.com/gortee/pictures/blob/master/D20.PNG)

Let's try to ping by IP address (replace with your ip address)

    ping -c 3 {ip_address}
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/D21.PNG)

Being able to reference the container via name has a huge benefit in dynamic environments.   Let's try to ping one of the containers on our bridge network my_container (172.17.0.2/16) or my_web_server (172.17.0.3/16).  

    ping -c 3 {ip_address}
    ping -c my_container
    
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D22.PNG)
 
 As you can see we have no path to access other containers unless they are exposing a port to the outside world.  my_web_server is exposing port 80 on the worker nodes port 8080 which would be accessable since the container and NAT to internet.   Networking exists only on a single host not across a clusters inside default docker which creates a lot of scalability challenges.   
 
## Docker-Image Creation
One function inside docker is the creation of your own images.   An image is a layer of things compiled into a very small package for distribution.  You define what should be in a image with a text file called Dockerfile.  Dockerfile definition is in layers which are loosely coupled then compiled together into a image by docker.   Is to use it in action.  You can find a complete list of command you can use in a Dockerfile at this site: https://docs.docker.com/engine/reference/builder/

Exit the container (type `exit`). 

Now let's create a blank directory for our new Dockerfile

    cd
    mkdir first
    cd  first

In order to avoid challenges with mistyping commands the Dockerfile has already been created.  Let's copy it from the clone git repository we downloaded.   

     cp ~/PKS-Lab/docker/first/Dockerfile .
   
Looking inside the Dockerfile we have the following:

     cat Dockerfile
     
![DockerOutput](https://github.com/gortee/pictures/blob/master/D23.PNG)

Breaking it down


FROM ubuntu:latest
 - Use the ubuntu base operating system with the tag of latest


RUN apt-get update -q && apt-get install -qy iputils-ping
 - Execute the command listed above that updates the operating system and installs iputils-ping 
 
 
CMD ["ping", "google.com"]
 - Run the command ping google.com forever
 
 So our basic container will use the latest ubunutu fully patched at time of image creation and ping google.com forever while running.   It sounds like a great container let's build the image.  We are going to call our image pinggoogle:
 
    docker build -t pinggoogle .

![DockerOutput](https://github.com/gortee/pictures/blob/master/D24.PNG)

Looking at the output above you can see how it is built in layers.  
 - Step 1 : Use ubuntu:latest which downloads the image if required and starts it
 - Step 2 : Run the command on the new blank ubuntu container
 - Step 3 : Run command
 - Remove intermediate containers used
 - Build image and tag it
 
You can see the current images on your host:

    docker images
    
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D25.PNG)
 
 As you can see image c02de73db6b9 was created and is 115MB in side.   This is the power of docker the whole container is only 115MB in side so it can be downloaded and started very quickly.   Let's run our new image:
 
     docker run pinggoogle
     
 Press CTRL-C to kill the container.   
 
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D26.PNG)
  

 Let's create a more complex image.  We will create a nginx based web server with a custom static page.  
 
     cd 
     mkdir second
     cd second
     cp ~/PKS-Lab/docker/second/Dockerfile ./
     
The contents of this Dockerfile are far more complex:

    cat Dockerfile
    
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D27.PNG)
 
In detail:
 - FROM the nginx:latest image
 - RUN a bunch of apt-get commands plus insall openssl
 - ENV set an environment vairable which can be rewritten on the command line if needed
 - COPY local file into the destination location on the image
 
Create a local file index.html to be inserted into your webserver
 
    echo "This is inside the container" > index.html

Let's build the image

    docker build -t pweb . 
    
This compile should require multiple steps and downloading for your image
 
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D28.PNG)
 
 Using the docker images command we can see our new image:
 
     docker images
     
  ![DockerOutput](https://github.com/gortee/pictures/blob/master/D29.PNG)
  
  You can see pweb is available to use and 127MB's.   You could then upload the image to docker hub or your own private repository (like Harbor) for reuse outside this single docker host.   Let's deploy and test pweb.  We are going to deploy it on the dev_network exposing internal port 80 on external 8080:
  
      docker run --name my_new_web -d -p 8000:80 pweb
      
 Visit cli-vm.corp.local:8000/index.html to see your file being served up.   
 
 Dockerfile can have many levels of complexity in order to create the image you want.   nginx is really a previously layer image of Ubuntu.   
 
## Clean up and Wordpress

For the final section in the docker lab we are going to clean up all currently running containers and images and run a new wordpress install.   Wordpress is being used to demostrate the challenges in creating multi-container solutions on docker.   

First lets stop all running containers:

    docker kill $(docker ps -q)
    docker ps
    
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D30.PNG)
  
  Remove all shutdown containers
  
      docker rm $(docker ps -a -q)
      docker ps -a
      
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/D31.PNG)
 
 Or hit it all with this command including networks
 
     docker system prune -a
     
  ![DockerOutput](https://github.com/gortee/pictures/blob/master/D32.PNG)
  
  Now we are all cleaned up and ready for a wordpress install (you just deleted the pweb image you created without any backup)
  
  Create a user network for wordpress
   
      docker network create wordpress
      
  Create a mysql container (normally you would not put passwords on the command line because they are stored in plain text)
  
      docker run --name db --network wordpress -e MYSQL_ROOT_PASSWORD=somepassword -d mysql:5.7
      
![DockerOutput](https://github.com/gortee/pictures/blob/master/D33.PNG)
  
  Create a apacheweb server with wordpress
  
      docker run --name web -p 888:80 --network wordpress -e WORDPRESS_DB_HOST=db:3306 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=somepassword -d wordpress 
      
![DockerOutput](https://github.com/gortee/pictures/blob/master/D34.PNG)

Wordpress should now be running on cli-vm.corp.local:888 visit it to see the wordpress configuration page.   When these containers exit everything will be lost.   

Before you stop this lab issue the following command to clean up everything

     docker system prune -a
     
## Challenge Activity
If you have time and want a challenge do the following
 - Build a apache web server listing on port 80 serving up php content
 - You can copy the index.php to serve up from ~/PKS-Lab/docker/challenge
 
 

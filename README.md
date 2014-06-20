# Latest nginx container
Linux (Ubuntu) image running latest nginx server. The system runs the following daemons
 * ssh
 * nginx
 * supervisor

# ssh
Please edit the Dockerfile to set the ssh key/deploy user

# run

    $ sudo docker run -d -P --name web -p 80:80 openmason/fleet-nginx

# Fleet-nginx
Linux (Ubuntu) image running latest stable nginx server. The system runs the following daemons, managed by circus
 * ssh
 * nginx

## fcgi/wsgi server
 * php5-fpm
 * chaussette 

# ssh
Please edit the Dockerfile to set the ssh key/deploy user

# run

    $ sudo docker run -d -P --name web -p 80:80 openmason/fleet-nginx

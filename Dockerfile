# Webserver (nginx) image description
#
# Usage:
# docker build -t openmason/fleet-nginx .
#
#
FROM openmason/fleet-pier:latest
MAINTAINER el aras<openmason@gmail.com>

# env variables
ENV nginx stable

# ppa repositories
RUN \
  add-apt-repository ppa:nginx/$nginx

# Install nginx
RUN \
  apt-get update; \
  apt-get install -yq nginx --no-install-recommends; \
  apt-get clean

# Remove the default Nginx configuration file
#RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
#ADD nginx.conf /etc/nginx/

# add "daemon off;" 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

# Set the default command to execute
# when creating a new container
CMD service nginx start


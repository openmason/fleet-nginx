# Webserver (nginx) image description
#
# Usage:
# docker build -t openmason/fleet-nginx .
#
#
FROM openmason/fleet-base:latest
MAINTAINER el aras<openmason@gmail.com>

# env variables
ENV nginx stable
ENV DEPLOY_USER openmason

# ppa repositories
RUN \
  add-apt-repository ppa:nginx/$nginx

# Install nginx
RUN \
  apt-get update; \
  ssh-import-id gh:$DEPLOY_USER; \
  apt-get install -yq nginx --no-install-recommends; \
  apt-get clean

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# copy default config files
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/sites-enabled /etc/nginx/sites-enabled
ADD supervisor/supervisord.conf /etc/supervisord.conf

# add "daemon off;" 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# mountable directories
#VOLUME ["/var/log/nginx", "/etc/nginx/sites-enabled"]

# Set the default command to execute
# when creating a new container
CMD ["/usr/local/bin/supervisord"]

# Expose ports
EXPOSE 22 80 443


# Webserver (nginx) image description
#
# Usage:
# docker build -t openmason/fleet-nginx .
#
#
FROM openmason/fleet-base:latest
MAINTAINER el aras<openmason@gmail.com>

# env variables
ENV DEPLOY_USER openmason

# ppa repositories
RUN add-apt-repository ppa:nginx/stable

# Install nginx
RUN \
  apt-get update; \
  ssh-import-id gh:$DEPLOY_USER; \
  apt-get install -yq nginx php5-fpm --no-install-recommends; \
  pip install circus-web chaussette; \
  apt-get clean

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# copy default config files
ADD nginx/nginx.conf     /etc/nginx/nginx.conf
ADD nginx/sites-enabled  /etc/nginx/sites-enabled
ADD circus/circusd.conf  /etc/circusd.conf

# add "daemon off;" 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# mountable directories
#VOLUME ["/var/log/nginx", "/etc/nginx/sites-enabled"]

# Set the default command to execute
# when creating a new container
CMD ["/usr/local/bin/circusd", "/etc/circusd.conf"]

# Expose ports
EXPOSE 22 80 443


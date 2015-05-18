FROM debian:jessie

MAINTAINER "Frank Kung" <kfanjian@gmail.com>

WORKDIR /tmp


# Install Nginx
RUN apt-get update -y && \
    apt-get install -y nginx

# Apply Nginx configuration
ADD docker/nginx.conf /opt/etc/nginx.conf
ADD docker/qinghua /etc/nginx/sites-available/qinghua
RUN ln -s /etc/nginx/sites-available/qinghua /etc/nginx/sites-enabled/qinghua && \
    rm /etc/nginx/sites-enabled/default

# Nginx startup script
ADD docker/nginx-start.sh /opt/bin/nginx-start.sh
RUN chmod u=rwx /opt/bin/nginx-start.sh

RUN mkdir -p /www/public
ADD . /www

# PORTS
EXPOSE 80
EXPOSE 443

WORKDIR /opt/bin
ENTRYPOINT ["/opt/bin/nginx-start.sh"]
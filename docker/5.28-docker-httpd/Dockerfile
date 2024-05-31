FROM ubuntu:latest

RUN apt update -y && \
    apt install apache2 -y && \
    apt clean all

#one way to copy a file from local machine to the container machine with direct path
COPY ./index /var/www/html

#another way to copy by cding into that working dir in the container
WORKDIR /var/www/html

COPY ./index .


VOLUME /var/log/httpd

CMD [ "apache2", "-D", "FOREGROUND" ]

FROM ubuntu:latest
RUN apt update -y && \
    apt install apache2 -y && \
    apt clean all

COPY ./web/index.html /var/www/html

EXPOSE 80

CMD [ "apache2ctl", "-D", "FOREGROUND" ]
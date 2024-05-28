FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y install apache2
COPY ./web/index.html /var/www/html
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
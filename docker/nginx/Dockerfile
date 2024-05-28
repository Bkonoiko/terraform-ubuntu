FROM nginx:latest

EXPOSE 80

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

COPY ./web/ /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
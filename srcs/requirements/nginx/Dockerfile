FROM debian:10.7 
RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl/private
RUN mkdir -p /etc/nginx/ssl/certs
RUN openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/private/swautele.key \
    -out /etc/nginx/ssl/certs/swautele.crt \
    -subj "/C=BE/ST=Bruxelles/L=Bruxelles/O=19 School/OU=swautele/CN=swautele/"

COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN mkdir -p /run/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
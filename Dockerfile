FROM debian:jessie

RUN mkdir -p /etc/postgrest

COPY .release/postgrest /usr/local/bin/postgrest 

CMD ["/usr/local/bin/postgrest", "-c", "/etc/postgrest/postgrest.conf"]

VOLUME ["/etc/postgrest"]

EXPOSE 3000
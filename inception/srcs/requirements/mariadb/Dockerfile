FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld

RUN chown -R mysql:mysql /run/mysqld

COPY tools/script.sh /script.sh

RUN chmod +x script.sh

CMD ["/script.sh"]
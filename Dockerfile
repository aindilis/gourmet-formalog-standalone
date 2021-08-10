FROM debian:buster

EXPOSE 9883

WORKDIR /root

COPY scripts/setup.pl  /root
COPY scripts/run.sh  /root

RUN apt-get update && ./setup.pl

CMD ["./run.sh"]

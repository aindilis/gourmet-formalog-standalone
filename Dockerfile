FROM debian:buster

EXPOSE 9883

RUN useradd andrewdo
WORKDIR /home/andrewdo

COPY scripts/setup.sh /home/andrewdo/
COPY scripts/setup.pl /home/andrewdo/
COPY scripts/run.sh /home/andrewdo/

RUN mkdir -p /var/lib/myfrdcsa/codebases/minor
RUN chown andrewdo.andrewdo /var/lib/myfrdcsa/codebases/minor
RUN apt-get update
RUN chmod +x /home/andrewdo/setup.pl
RUN chown andrewdo.andrewdo /home/andrewdo/setup.pl
RUN /home/andrewdo/setup.sh

CMD ["/home/andrewdo/run.sh"]

FROM debian:buster

USER root
LABEL maintainer = "adougher9@yahoo.com"
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive
ARG --security-opt seccomp:unconfined

EXPOSE 9883

RUN useradd andrewdo
WORKDIR /home/andrewdo

COPY scripts/setup.sh /home/andrewdo/
COPY scripts/setup.pl /home/andrewdo/
COPY scripts/run.sh /home/andrewdo/

RUN mkdir -p /var/lib/myfrdcsa/codebases/minor
RUN chown -R andrewdo.andrewdo /var/lib/myfrdcsa/codebases/minor
RUN mkdir -p /var/lib/myfrdcsa/codebases/minor-data
RUN chown -R andrewdo.andrewdo /var/lib/myfrdcsa/codebases/minor-data

RUN chown -R andrewdo.andrewdo /home/andrewdo
RUN apt-get update
RUN chmod +x /home/andrewdo/setup.pl
RUN chown andrewdo.andrewdo /home/andrewdo/setup.pl
RUN /home/andrewdo/setup.sh

CMD ["/home/andrewdo/run.sh"]

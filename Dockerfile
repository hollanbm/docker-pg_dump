ARG PG_VERSION
FROM postgres:${PG_VERSION}

RUN apt-get update -y -qq && apt-get dist-upgrade -y -qq && apt-get autoremove -y -qq

ADD dump.sh /dump.sh
RUN chmod +x /dump.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /dump

ENTRYPOINT ["/start.sh"]

FROM debian:bookworm-slim

LABEL authors="Auto*Mat, z. s. auto-mat@auto-mat.cz"
LABEL maintainer="Auto*Mat, z. s. auto-mat@auto-mat.cz"

ENV MAPSERVER_MAP_FILE_DIR=/opt/mapserver/ \
    MS_DEBUGLEVEL=0 \
    MS_ERRORFILE=stderr \
    MAPSERVER_CONFIG_FILE=/etc/mapserver.conf \
    MAPSERVER_BASE_PATH= \
    MAX_REQUESTS_PER_PROCESS=1000 \
    MIN_PROCESSES=1 \
    MAX_PROCESSES=5 \
    BUSY_TIMEOUT=300 \
    IDLE_TIMEOUT=300 \
    IO_TIMEOUT=40 \
    APACHE_LIMIT_REQUEST_LINE=8190

RUN apt-get update && apt-get install -y \
    apache2 \
    cgi-mapserver \
    curl \
    mapserver-bin \
    libapache2-mod-fcgid \
    supervisor \
    wget \
    && a2enmod headers status \
    && apt-get clean

# Create the directories we will need
RUN mkdir -p /opt/mapserver /var/run/apache2 /var/www/localhost/cgi-bin/ \
    && ln -s /usr/bin/mapserv /var/www/localhost/cgi-bin/mapserv

COPY ./supervisord.conf /etc/supervisor/conf.d/
COPY ./mapserver/apache2/47_mod_mapserver.conf /etc/apache2/modules.d/
COPY ./mapserver/apache2/mapserver.conf /etc/apache2/conf-enabled/
COPY ./mapserver/mapserver.conf /etc/
COPY ./mapserver/base_maps.map $MAPSERVER_MAP_FILE_DIR
COPY ./run.sh /usr/local/bin/

WORKDIR $MAPSERVER_MAP_FILE_DIR

RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["run.sh"]

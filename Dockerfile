FROM linuxserver/nzbget:latest
MAINTAINER sparklyballs


# install nzbToMedia
RUN \
 git clone https://github.com/clinton-hall/nzbToMedia /app/scripts/nzbToMedia


# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /scripts
EXPOSE 6789

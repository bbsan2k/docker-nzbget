FROM lsiobase/alpine
MAINTAINER sparklyballs

# package version
# (stable-download or testing-download)
ARG NZBGET_BRANCH="stable-download"

# install packages
RUN \
 apk add --no-cache \
	curl \
	p7zip \
	python \
	unrar \
	wget \
	git

# install nzbget
RUN \
 curl -o \
 /tmp/json -L \
	http://nzbget.net/info/nzbget-version-linux.json && \
 NZBGET_VERSION=$(grep "${NZBGET_BRANCH}" /tmp/json  | cut -d '"' -f 4) && \
 curl -o \
 /tmp/nzbget.run -L \
	"${NZBGET_VERSION}" && \
 sh /tmp/nzbget.run --destdir /app && \


# cleanup
 rm -rf \
	/tmp/* && \


#install nzbToMedia
 git clone https://github.com/clinton-hall/nzbToMedia /app/scripts/nzbToMedia


# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /scripts
EXPOSE 6789

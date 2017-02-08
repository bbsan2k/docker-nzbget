FROM linuxserver/nzbget:latest
MAINTAINER sparklyballs


# install ffmpeg
ENV NZBTOMEDIA_BRANCH=master

# install runtime dependencies
RUN \
 apk add --no-cache \
 	bzip2 \
	freetype \
	git \
	lcms2 \
	py-lxml \
	py-pip \
	python \
	tar \
	unzip \
	xz \
	zlib && \
 apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing \
	vnstat && \


# add pip packages
 #pip install --no-cache-dir -U \
 #	pip && \
 #LIBRARY_PATH=/lib:/usr/lib \
 pip install --no-cache-dir -U \
	configparser \
	requests \
	urllib3 \
	virtualenv



RUN apk add --update ffmpeg

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /scripts
EXPOSE 6789

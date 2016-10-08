FROM linuxserver/nzbget:latest
MAINTAINER sparklyballs

# install runtime dependencies
RUN \
 apk add --no-cache \
	curl \
	freetype \
	git \
	lcms2 \
	py-lxml \
	py-pip \
	python \
	tar \
	unrar \
	unzip \
	wget \
	xz \
	zlib && \

 apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing \
	vnstat && \

# install build dependencies
 apk add --no-cache --virtual=build-dependencies \
	autoconf \
	automake \
	freetype-dev \
	g++ \
	gcc \
	jpeg-dev \
	lcms2-dev \
	libffi-dev \
	libpng-dev \
	libwebp-dev \
	linux-headers \
	make \
	openjpeg-dev \
	openssl-dev \
	python-dev \
	tiff-dev \
	zlib-dev && \

# add pip packages
 pip install --no-cache-dir -U \
	pip && \
 LIBRARY_PATH=/lib:/usr/lib \
 pip install --no-cache-dir -U \
	configparser \
	requests \
	urllib3 \
	virtualenv && \

# clean up
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*



# install nzbToMedia
#RUN \
# git clone https://github.com/clinton-hall/nzbToMedia /app/scripts/nzbToMedia


# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /scripts
EXPOSE 6789

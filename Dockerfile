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
	zlib \
	ffmpeg



# add pip packages
 RUN pip install --no-cache-dir -U \
	configparser \
	requests \
	urllib3 \
	virtualenv

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /scripts
EXPOSE 6789

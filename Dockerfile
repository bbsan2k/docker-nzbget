FROM linuxserver/nzbget:latest
MAINTAINER bbsan


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

RUN pip install --upgrade PIP


# add pip packages
RUN pip install --no-cache-dir -U \
	configparser \
	requests \
	urllib3 \
	virtualenv \
    requests[security] \
	requests-cache \
	babelfish \
	"guessit<2"\
	"subliminal<2"\ 
	qtfaststart
# As per https://github.com/mdhiggins/sickbeard_mp4_automator/issues/643
ONBUILD RUN pip uninstall stevedore
ONBUILD RUN pip install stevedore==1.19.1

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /scripts
EXPOSE 6789

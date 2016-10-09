FROM linuxserver/nzbget:latest
MAINTAINER sparklyballs


# install ffmpeg
ENV FFMPEG_VERSION=3.0.2

# install runtime dependencies
RUN \
 apk add --no-cache \
 	bzip2 \
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
	nasm \
	openjpeg-dev \
	openssl-dev \
	python-dev \
	tiff-dev \
	yasm-dev \
	zlib-dev && \

# add pip packages
 pip install --no-cache-dir -U \
	pip && \
 LIBRARY_PATH=/lib:/usr/lib \
 pip install --no-cache-dir -U \
	configparser \
	requests \
	urllib3 \
	virtualenv





RUN apk add --update build-base  \
  lame-dev libogg-dev x264-dev \
  libvpx-dev libvorbis-dev x265-dev libass-dev \ 
  rtmpdump-dev libtheora-dev opus-dev && \

  DIR=$(mktemp -d) && cd ${DIR} && \

  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame \
  --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis \
  --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc \
  --enable-avresample --enable-libfreetype --enable-openssl --disable-debug && \
  make && \
  make install && \
  make distclean && \

  rm -rf ${DIR}

# clean up
RUN apk del --purge \
	build-dependencies \
	build-base && \
 rm -rf \
	/root/.cache \
	/tmp/*



# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /scripts
EXPOSE 6789

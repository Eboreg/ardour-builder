FROM debian

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y autoconf automake bzip2 chrpath cmake g++ gcc intltool itstool libarchive-dev libasound2-dev \
    libaubio-dev libbison-dev libboost-dev libcairo2-dev libcairomm-1.16-dev libcppunit-dev libcurl4-gnutls-dev \
    libexpat1-dev libffi-dev libfftw3-dev libflac-dev libfontconfig-dev libfreetype-dev libfribidi-dev \
    libgettextpo-dev libglib2.0-dev libglibmm-2.4-dev libgtk2.0-dev libharfbuzz-dev libjack-jackd2-dev liblo-dev \
    liblrdf0-dev libnss3-dev libogg-dev libopus-dev libpango1.0-dev libpangomm-1.4-dev libpcre2-dev libpixman-1-dev \
    libpixman-1-dev libpng-dev libpulse-dev libraptor2-dev librasqal3-dev librdf0-dev libreadline-dev \
    librubberband-dev libsamplerate0-dev libsigc++-2.0-dev libssl-dev libtag1-dev libtiff-dev libtool \
    libusb-1.0-0-dev libvorbis-dev libxext-dev libxml2-dev libxslt1-dev m4 make ninja-build nss-plugin-pem pkg-config \
    python-is-python3 python3 redland-utils rsync unzip util-linux vamp-plugin-sdk xz-utils zlib1g-dev

COPY build /build/
WORKDIR /build

RUN ./build-dep.sh jpeg
RUN ./build-dep.sh libiconv
RUN ./build-dep.sh libwebsockets
RUN ./build-dep.sh flex
RUN ./build-dep.sh libsndfile
RUN ./build-dep.sh serd
RUN ./build-dep.sh lv2
RUN ./build-dep.sh sord
RUN ./build-dep.sh sratom
RUN ./build-dep.sh lilv
RUN ./build-dep.sh ardour

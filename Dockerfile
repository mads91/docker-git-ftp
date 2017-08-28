FROM ubuntu:16.04
MAINTAINER Mads Hansen <mh@baernholdt.com>

# install git and git-ftp
RUN apt-get -qq update && apt-get -qq install git && apt-get -qq install wget

# Rebuild curl with sftp support
#RUN apt-get install -y build-essential debhelper libssh2-1-dev
#RUN apt-get source curl
#RUN apt-get build-dep -y curl
#RUN cd curl-*
#RUN DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage
#RUN cd ..
#RUN dpkg -i curl*.deb libcurl3-nss*.deb libcurl4-doc*.deb libcurl4-openssl*.deb libcurl3_*.deb

RUN apt-get -qq install build-essential nghttp2 libnghttp2-dev
RUN wget https://curl.haxx.se/download/curl-7.54.0.tar.bz2
RUN tar -xvjf curl-7.54.0.tar.bz2
RUN cd curl-7.54.0 && ./configure --with-nghttp2 --prefix=/usr/local && make && make install
RUN ldconfig



# Use "drench" version which support `git ftp fetch`
RUN cd /usr/local/src
RUN git clone -b feature/lftp https://github.com/drench/git-ftp.git
RUN cd git-ftp && make install
RUN apt-get install -y lftp
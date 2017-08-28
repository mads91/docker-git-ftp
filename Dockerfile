FROM ubuntu:16.04
MAINTAINER Mads Hansen <mh@baernholdt.com>

# install git and git-ftp
RUN apt-get -qq update && apt-get -qq install git wget libssl-dev

# Rebuild curl with sftp support
#RUN apt-get install -y build-essential debhelper libssh2-1-dev
#RUN apt-get source curl
#RUN apt-get build-dep -y curl
#RUN cd curl-*
#RUN DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage
#RUN cd ..
#RUN dpkg -i curl*.deb libcurl3-nss*.deb libcurl4-doc*.deb libcurl4-openssl*.deb libcurl3_*.deb

RUN apt-get -qq install build-essential
RUN wget https://www.libssh2.org/download/libssh2-1.8.0.tar.gz
RUN tar -xvzf libssh2-1.8.0.tar.gz
RUN cd libssh2-1.8.0 && ./configure && make && make install
RUN wget https://curl.haxx.se/download/curl-7.54.0.tar.bz2
RUN tar -xvjf curl-7.54.0.tar.bz2
RUN cd curl-7.54.0 && ./configure --with-libssh2=/usr/local && make && make install
RUN ldconfig



# Use "drench" version which support `git ftp fetch`
RUN cd /usr/local/src
RUN git clone -b feature/lftp https://github.com/drench/git-ftp.git
RUN cd git-ftp && make install
RUN apt-get install -y lftp
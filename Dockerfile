FROM ubuntu:16.04
MAINTAINER Mads Hansen <mh@baernholdt.com>

# install git and other deps
RUN apt-get -qq update && apt-get -qq install git wget libssl-dev build-essential git-ftp

# get and build libssh2 and curl
RUN wget https://www.libssh2.org/download/libssh2-1.8.0.tar.gz
RUN tar -xvzf libssh2-1.8.0.tar.gz
RUN cd libssh2-1.8.0 && ./configure && make && make install
RUN wget https://curl.haxx.se/download/curl-7.54.0.tar.bz2
RUN tar -xvjf curl-7.54.0.tar.bz2
RUN cd curl-7.54.0 && ./configure --with-libssh2=/usr/local && make && make install
RUN ldconfig
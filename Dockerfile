FROM ubuntu:16.04
MAINTAINER Mads Hansen <mh@baernholdt.com>

# install git and git-ftp
RUN apt-get -y update && apt-get -qq install git && apt-get -qq install git-ftp
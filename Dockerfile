FROM ubuntu:16.04
MAINTAINER Mads Hansen <mh@baernholdt.com>

# install git and git-ftp
RUN apt-get -y update && apt-get -y install git git-ftp && apt-get clean
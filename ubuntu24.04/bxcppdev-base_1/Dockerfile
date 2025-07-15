# bxcppdev-ubuntu24.04-base

FROM ubuntu:24.04

LABEL version="1.0" maintainer="F.Mauger <mauger@lpccaen.in2p3.fr>"

RUN ["/bin/bash", "-c", "echo" , "Switching to bash..."]
SHELL ["/bin/bash", "-c"]

# testing proxy:
# ENV http_proxy="${proxy_value}"
# ENV https_proxy="${proxy_value}"
# RUN echo "http_proxy=${http_proxy}"
# RUN echo "https_proxy=${https_proxy}"

ARG _apt_flags="-q -y"
RUN  apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install ${_apt_flags} tzdata

RUN apt-get update -y \
  && apt-get install ${_apt_flags} \
    coreutils \
    bash \
    tree \
    dpkg-dev \
    emacs \
    nano \
    dialog \
    xterm \
    sudo \
    wget \
    curl \
    make pkg-config wget g++ gcc \
    docutils-common docutils-doc rst2pdf \
    cmake ninja-build git \
  && apt-get clean 

RUN wget https://fr.wikipedia.org/

ARG _sw_root_dir="/opt/DockerSW/ubuntu24.04/bxcppdev"
ENV SW_ROOT_DIR="${_sw_root_dir}"
RUN mkdir -p ${SW_ROOT_DIR} \
  && chmod 1777 ${SW_ROOT_DIR} 
 	  
WORKDIR ${SW_ROOT_DIR}





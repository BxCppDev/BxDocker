# bxcppdev-ubuntu22.04-bayeux:3.5.5

FROM bxcppdev-ubuntu22.04-bx3build:1
LABEL version="1.0" maintainer="F.Mauger <mauger@lpccaen.in2p3.fr>"
ARG APT_FLAGS="-q -y"
ARG BX_INSTALLERS_OPTIONS="--no-system-dependencies"

RUN echo "BX_CACHE_DIR=${BX_CACHE_DIR}"
RUN echo "BX_INSTALL_BASE_DIR=${BX_INSTALL_BASE_DIR}"
RUN echo "BX_CONFIG_DIR=${BX_CONFIG_DIR}"
# RUN echo "UID=${UID}"
RUN ["/bin/bash", "-c", "echo" , "Switching to bash..."]
SHELL ["/bin/bash", "-c"]

#############################################
RUN \
  mkdir -p ${BX_CACHE_DIR} \
  && mkdir -p ${BX_WORK_DIR} \
  && mkdir -p ${BX_INSTALL_BASE_DIR} \
  && mkdir -p ${BX_CONFIG_DIR} \
  && apt-get update -y \
  && apt-get install ${APT_FLAGS} \
    less \
    libqt5core5a \
    libqt5gui5 \
    libqt5svg5 \
    libqt5svg5-dev \
    libqt5widgets5 \
    qtbase5-dev qtbase5-dev-tools \
    &&  apt-get clean


#############################################
RUN \
  cd ${SW_ROOT_DIR} \
  && ls -a . \
  && cd BxInstallers \
  && ls -a . \
  && cd bxinstallers.git \
  && git pull \
  && cd .. \
  && mkdir _build.d \
  && cd _build.d \
  && cmake -DCMAKE_INSTALL_PREFIX="${SW_ROOT_DIR}/bxinstallers" ../bxinstallers.git \
  && make install \
  && cd .. 
 

#############################################
ARG bayeux_version="3.5.5"
ARG bayeux_uversion="3_5_5"

RUN \
  source ${BX_BAYEUX_BUILD_SETUP_SCRIPT} \
  && bayeux_build_setup \
  && cd ${SW_ROOT_DIR}/BxInstallers/bxinstallers.git/BxBayeuxInstaller/ \
  && bash bayeux_installer --package-version "${bayeux_version}" \
    --with-geant4 \
    --cxx-17 \
    ${BX_INSTALLERS_OPTIONS} 

#############################################
ENV BX_BAYEUX_SETUP_SCRIPT=${BX_CONFIG_DIR}/modules/bayeux@${bayeux_version}.bash
ENV BX_BAYEUX_VERSION="${bayeux_version}"
ENV BX_BAYEUX_UVERSION="${bayeux_uversion}"


#############################################
RUN \
    find ${BX_CACHE_DIR}/ -name "*.tar.gz" -exec rm -f \{\} \;  \
    && find ${BX_CACHE_DIR}/ -name "*.tgz" -exec rm -f \{\} \;  \
    && rm -fr ${BX_CACHE_DIR}/bayeux-${bayeux_version} \
    && rm -fr ${BX_WORK_DIR}/bayeux-@${bayeux_version}

# end





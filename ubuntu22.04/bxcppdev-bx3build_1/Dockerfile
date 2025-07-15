# bxcppdev-ubuntu22.04-bx3build

FROM bxcppdev-ubuntu22.04-base:1

LABEL version="1.0" maintainer="F.Mauger <mauger@lpccaen.in2p3.fr>"

RUN echo "SW_ROOT_DIR=${SW_ROOT_DIR}"

ARG APT_FLAGS="-q -y"

# ARG BX_INSTALLERS_OPTIONS="--no-system-dependencies --remove-build-dir --remove-tarballs"
ARG BX_INSTALLERS_OPTIONS="--no-system-dependencies"

ARG BX_MODULES=""
ENV BX_CACHE_DIR="${SW_ROOT_DIR}/BxSoftware/BxCache"
ENV BX_WORK_DIR="${SW_ROOT_DIR}/BxSoftware/BxWork"
ENV BX_INSTALL_BASE_DIR="${SW_ROOT_DIR}/BxSoftware/BxInstall"
ENV BX_CONFIG_DIR="${SW_ROOT_DIR}/BxSoftware/BxConfig"

RUN echo "BX_CACHE_DIR=${BX_CACHE_DIR}"
RUN echo "BX_INSTALL_BASE_DIR=${BX_INSTALL_BASE_DIR}"
RUN echo "BX_CONFIG_DIR=${BX_CONFIG_DIR}"


#############################################
RUN \
  mkdir -p ${BX_CACHE_DIR} \
  && mkdir -p ${BX_WORK_DIR} \
  && mkdir -p ${BX_INSTALL_BASE_DIR} \
  && mkdir -p ${BX_CONFIG_DIR} \
  && apt-get update -y \
  && apt-get install ${APT_FLAGS} \
    doxygen \
    libboost-all-dev \
    libcamp-dev \
    libreadline-dev \
    libqt5core5a libqt5svg5 libqt5svg5-dev libqt5gui5 libqt5widgets5 \
    qtbase5-dev qtbase5-dev-tools \
    gnuplot-qt \
    libgsl-dev gsl-bin \
    libxerces-c-dev \
    expat libexpat1 libexpat1-dev \
    libx11-6 libx11-dev \
    libxmu6 libxmu-dev \
    libxext6 libxext-dev \
  && apt-get clean


#############################################
RUN \
  cd ${SW_ROOT_DIR} && \
  mkdir BxInstallers && \
  cd BxInstallers && \
  git clone https://github.com/BxCppDev/BxInstallers bxinstallers.git && \
  mkdir _build.d && \
  cd _build.d && \
  cmake -DCMAKE_INSTALL_PREFIX="${SW_ROOT_DIR}/bxinstallers" ../bxinstallers.git && \
  make install && \
  cd .. && \
  rm -fr _build.d && \
  tree ${SW_ROOT_DIR}/bxinstallers

ENV PATH="${SW_ROOT_DIR}/bxinstaller/bin:${PATH}"


#############################################
ARG clhep_version="2.1.4.2"
ARG clhep_uversion="2_1_4_2"
RUN \
  cd ${SW_ROOT_DIR}/BxInstallers/bxinstallers.git/BxClhepInstaller && \
  bash clhep_installer --package-version "${clhep_version}" ${BX_INSTALLERS_OPTIONS} 

ARG BX_MODULES="clhep@${clhep_version}"
ENV BX_CLHEP_SETUP_SCRIPT=${BX_CONFIG_DIR}/modules/clhep@${clhep_version}.bash


#############################################
ARG bxdecay0_version="1.1.2"
ARG bxdecay0_uversion="1_1_2"
RUN \
  cd ${SW_ROOT_DIR}/BxInstallers/bxinstallers.git/BxDecay0Installer/ && \
  bash bxdecay0_installer --package-version "${bxdecay0_version}" ${BX_INSTALLERS_OPTIONS}

ARG BX_MODULES="${BX_MODULES}:bxdecay0@${bxdecay0_version}"
ENV BX_BXDECAY0_SETUP_SCRIPT=${BX_CONFIG_DIR}/modules/bxdecay0@${bxdecay0_version}.bash


#############################################
ARG bxg4datasets_version="9.6.4"
ARG bxg4datasets_uversion="9_6_4"
RUN \
  cd ${SW_ROOT_DIR}/BxInstallers/bxinstallers.git/BxGeant4DatasetsInstaller/ && \
  bash g4datasets_installer --package-version "${bxg4datasets_version}" ${BX_INSTALLERS_OPTIONS}
 
ARG BX_MODULES="${BX_MODULES}:g4datasets@${bxg4datasets_version}"
ENV BX_G4DATASETS_SETUP_SCRIPT=${BX_CONFIG_DIR}/modules/g4datasets@${bxg4datasets_version}.bash


#############################################
ARG bxgeant4_version="9.6.4"
ARG bxgeant4_uversion="9_6_4"
RUN \
  source ${BX_CLHEP_SETUP_SCRIPT} && \
  clhep_${clhep_uversion}_setup && \
  source ${BX_G4DATASETS_SETUP_SCRIPT} && \
  g4datasets_${bxg4datasets_uversion}_setup && \
  cd ${SW_ROOT_DIR}/BxInstallers/bxinstallers.git/BxGeant4Installer/ && \
  bash geant4_installer --package-version "${bxg4datasets_version}" --cxx-11 ${BX_INSTALLERS_OPTIONS}
 
ARG BX_MODULES="${BX_MODULES}:geant4@${bxgeant4_version}"
ENV BX_GEANT4_SETUP_SCRIPT=${BX_CONFIG_DIR}/modules/geant4@${bxgeant4_version}.bash


#############################################
RUN \
  apt-get update -y \
  && apt install ${APT_FLAGS} binutils cmake dpkg-dev g++ gcc gfortran git libafterimage-dev libavahi-compat-libdnssd-dev libbz2-dev libcfitsio-dev libfftw3-dev libfreetype6-dev libftgl-dev libftgl-dev  libgif-dev libgl2ps-dev libgl2ps-dev  libglew-dev libglu1-mesa-dev libgraphviz-dev libgraphviz-dev  libgsl-dev gsl-bin libjpeg-dev libkrb5-dev  libldap2-dev  liblz4-dev liblzma-dev libmariadb-dev libpcre3-dev libpcre3-dev  libpng-dev libreadline-dev libsqlite3-dev libssl-dev libtbb-dev libtiff5-dev libx11-dev libx11-dev  libxext-dev libxft-dev libxml2-dev libxpm-dev libxxhash-dev libzstd-dev nlohmann-json3-dev python3 python3-dev python3-numpy qtwebengine5-dev zlib1g-dev \
  && apt-get clean

# ARG bxroot_version="6.26.06"
# ARG bxroot_uversion="6_26_06"
# RUN \
#   cd ${SW_ROOT_DIR}/BxInstallers/bxinstallers.git/BxRootInstaller/ && \
#   bash root_installer --package-version "${bxroot_version}" \
#     --system-tbb \
#     --without-xrootd \
#     --nprocs 4 \
#     --cxx14 \
#     ${BX_INSTALLERS_OPTIONS}
#

# Build options: https://root.cern.ch/install/build_from_source/
ARG bxroot_version="6.34.06"
RUN \
   cd ${BX_CACHE_DIR} \
   && wget https://root.cern/download/root_v${bxroot_version}.source.tar.gz \
   && mkdir -p ${BX_WORK_DIR}/root-${bxroot_version} \
   && tar xzf ${BX_CACHE_DIR}/root_v${bxroot_version}.source.tar.gz -C ${BX_CACHE_DIR} \
   && ls -al ${BX_CACHE_DIR}/root-${bxroot_version}/ \
   && mkdir -p ${BX_WORK_DIR}/root-${bxroot_version}/ \
   && cd ${BX_WORK_DIR}/root-${bxroot_version} \
   && cmake \
     -DCMAKE_INSTALL_PREFIX:PATH=${BX_INSTALL_BASE_DIR}/root-${bxroot_version} \
     -DCMAKE_BUILD_TYPE:STRING="Release" \
     -DCMAKE_CXX_STANDARD=17 \
     -Dxrootd=OFF \
     -Dgnuinstall=ON \
     -Dbuiltin_xrootd=OFF \
     -Dbuiltin_nlohmannjson=ON \
     -Dbuiltin_tbb=OFF -DTBB_ROOT_DIR=/usr \
     -Dsoversion=ON \
     -Dmathmore=ON \
      -G Ninja \
      ${BX_CACHE_DIR}/root-${bxroot_version} \
   && ninja -j 8
   
RUN \
   cd ${BX_WORK_DIR}/root-${bxroot_version} \
   && ninja install

ARG BX_MODULES="${BX_MODULES}:root@${bxroot_version}"
ENV BX_ROOT_SETUP_SCRIPT=${BX_INSTALL_BASE_DIR}/root-${bxroot_version}/bin/thisroot.sh


#############################################
ENV BX_CLHEP_VERSION="${clhep_version}"
ENV BX_CLHEP_UVERSION="${clhep_uversion}"
ENV BX_BXDECAY0_VERSION="${bxdecay0_version}"
ENV BX_BXDECAY0_UVERSION="${bxdecay0_uversion}"
ENV BX_G4DATASETS_VERSION="${bxg4datasets_version}"
ENV BX_G4DATASETS_UVERSION="${bxg4datasets_uversion}"
ENV BX_GEANT4_VERSION="${bxgeant4_version}"
ENV BX_GEANT4_UVERSION="${bxgeant4_uversion}"
ENV BX_ROOT_VERSION="${bxroot_version}"

   
#############################################
RUN \
    find ${BX_CACHE_DIR}/ -name "*.tar.gz" -exec rm -f \{\} \;  \
    && find ${BX_CACHE_DIR}/ -name "*.tgz" -exec rm -f \{\} \;  \
    && rm -fr ${BX_CACHE_DIR}/${clhep_version} \
    && rm -fr ${BX_CACHE_DIR}/bxdecay0-${bxdecay0_version}  \
    && rm -fr ${BX_CACHE_DIR}/geant4.9.6.p04  \
    && rm -fr ${BX_CACHE_DIR}/root-${bxroot_version}  \
    && rm -fr ${BX_WORK_DIR}/clhep-${clhep_version} \
    && rm -fr ${BX_WORK_DIR}/bxdecay0-${bxdecay0_version}  \
    && rm -fr ${BX_WORK_DIR}/g4datasets-${bxg4datasets_version}  \
    && rm -fr ${BX_WORK_DIR}/geant4-@${bxgeant4_version}  \
    && rm -fr ${BX_WORK_DIR}/root-@${bxroot_version}


#############################################

RUN mkdir -p /etc/bash.init

ADD bayeux_build_setup.bash ${BX_CONFIG_DIR}/
ENV BX_BAYEUX_BUILD_SETUP_SCRIPT=${BX_CONFIG_DIR}/bayeux_build_setup.bash
ENV BX_MODULES="${BX_MODULES}"

WORKDIR ${SW_ROOT_DIR}

# end





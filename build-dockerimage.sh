#!/bin/bash
# usage: build-dockerimage.sh /cygdrive/d/Projekte/yaio-playground/

# check yaio_srcdir
BASE_DIR=$(dirname $(readlink -f $0))/
YAIO_SRC_BASE=$1

if [ "${YAIO_SRC_BASE}" = "" ]; then
   echo "YAIO_SRC_BASE required - eq."
   echo "   ./build-dockerimage.sh /cygdrive/d/Projekte/yaio-playground/"
   exit -1
fi

PWD=`pwd`

###################
## extract yaio-version
###################
cd ${YAIO_SRC_BASE}
YAIO_VERSION=`printf 'VERSION=${project.version}\n0\n' | \
              mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate | \
              grep '^VERSION' | \
              sed -e 's/VERSION=\(.*\)/\1/'`

###################
## Build yaio
###################
cd ${BASE_DIR}
${BASE_DIR}/setup-build.sh ${YAIO_SRC_BASE}

###################
## Configure docker
###################
DOCKER_SRC_DIR=./yaio
BASE_TAG=yaio/yaioserver
BASE_VERSION=`date +%Y%m%d_%H%M%S`
VERSION_TAGS=""
#VERSION_TAGS="${VERSION_TAGS} -t ${BASE_TAG}:${BASE_VERSION}"
VERSION_TAGS="${VERSION_TAGS} -t ${BASE_TAG}:${YAIO_VERSION}"

###################
## Build docker
###################
cd ${BASE_DIR}
RUN_CMD="docker build -f ${DOCKER_SRC_DIR}/Dockerfile ${VERSION_TAGS} ${DOCKER_SRC_DIR}/"
echo "do ${RUN_CMD}"
${RUN_CMD}

###################
## Back
###################
cd ${PWD}

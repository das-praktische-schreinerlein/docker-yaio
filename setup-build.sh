#!/bin/bash
# usage: setup-build.sh /cygdrive/d/Projekte/yaio-playground/

# check yaio_srcdir
YAIO_SRC_BASE=$1

if [ "${YAIO_SRC_BASE}" = "" ]; then
   echo "YAIO_SRC_BASE required - for instance"
   echo "   ./setup-build.sh /cygdrive/d/Projekte/yaio-playground/"
   exit -1
fi

###################
## Configure and package yaio
###################
BASE_DIR=$(dirname $(readlink -f $0))/
DOCKER_SRC_DIR=${BASE_DIR}/yaio
YAIO_BUILD_DIR=${DOCKER_SRC_DIR}/build

# prepare build-dir
rm -fr ${YAIO_BUILD_DIR}
mkdir -p ${YAIO_BUILD_DIR}

# create empty dirs
mkdir -p ${YAIO_BUILD_DIR}/config
mkdir -p ${YAIO_BUILD_DIR}/dist
mkdir -p ${YAIO_BUILD_DIR}/logs
mkdir -p ${YAIO_BUILD_DIR}/queues/fileimportqueue
mkdir -p ${YAIO_BUILD_DIR}/queues/mailimportqueue
mkdir -p ${YAIO_BUILD_DIR}/resources
mkdir -p ${YAIO_BUILD_DIR}/sbin
mkdir -p ${YAIO_BUILD_DIR}/storage
mkdir -p ${YAIO_BUILD_DIR}/tmp
mkdir -p ${YAIO_BUILD_DIR}/var/hsqldb
mkdir -p ${YAIO_BUILD_DIR}/var/tessdata

# copy data
cp -r ${YAIO_SRC_BASE}/config/* ${YAIO_BUILD_DIR}/config/
#cp -r ${YAIO_SRC_BASE}/dist/yaio-app-cli-full.jar ${YAIO_BUILD_DIR}/dist/
cp -r ${YAIO_SRC_BASE}/dist/yaio-app-server-full.jar ${YAIO_BUILD_DIR}/dist/
#cp -r ${YAIO_SRC_BASE}/dist/yaio-app-serverclient-full.jar ${YAIO_BUILD_DIR}/dist/
cp -r ${YAIO_SRC_BASE}/sbin/* ${YAIO_BUILD_DIR}/sbin/
cp -r ${YAIO_SRC_BASE}/resources/* ${YAIO_BUILD_DIR}/resources/
cp -r ${YAIO_SRC_BASE}/var/nodeids.properties ${YAIO_BUILD_DIR}/var/
cp -r ${YAIO_SRC_BASE}/var/tessdata/* ${YAIO_BUILD_DIR}/var/tessdata/

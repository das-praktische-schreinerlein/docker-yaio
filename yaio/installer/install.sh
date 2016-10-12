#!/bin/bash
###################
## Configure and package yaio
###################

SCRIPT_DIR=/opt/yaio_home/installer
BASE_DIR=/opt/yaio_home/
CONFIG_DIR=${BASE_DIR}/config

# load utils
. ${SCRIPT_DIR}/utils.sh

# Config anpassen

# config/application.properties
replaceConfigFileBySed ${CONFIG_DIR}/yaio-application.properties ${SCRIPT_DIR}/application.properties.sed

# config/log4j.properties
replaceConfigFileBySed ${CONFIG_DIR}/log4j.properties ${SCRIPT_DIR}/log4j.properties.sed

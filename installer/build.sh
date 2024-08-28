#!/bin/bash

ROOT_DIR=$(dirname $0)

if [ -d ${ROOT_DIR}/build ] ; then
    rm -rf ${ROOT_DIR}/build/
fi
mkdir ${ROOT_DIR}/build

cp -r ${ROOT_DIR}/ddp-gdbinstaller ${ROOT_DIR}/build/

SCRIPT_CONFIG_MAP=${ROOT_DIR}/build/ddp-gdbinstaller/templates/configmap-scripts.yaml
echo "  install.sh: |" >> ${SCRIPT_CONFIG_MAP}
cat ${ROOT_DIR}/install.sh | sed 's/^/    /' >> ${SCRIPT_CONFIG_MAP}

helm package --destination ${ROOT_DIR}/build ${ROOT_DIR}/build/ddp-gdbinstaller

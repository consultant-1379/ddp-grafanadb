#!/bin/bash

DASHBOARDS_TGZ_URL=$1
echo "DASHBOARDS_TGZ_URL=${DASHBOARDS_TGZ_URL}"
ls -l /dashboards

HTTP_CODE=$(curl --silent --output /dashboards/db.tgz --write-out "%{http_code}" ${DASHBOARDS_TGZ_URL})
if [ ${HTTP_CODE} -lt 200 ] || [ ${HTTP_CODE} -gt 299 ] ; then
    echo "ERROR: Failed to fetch ${DASHBOARDS_TGZ_URL}"
    exit 1
fi

if [ -d /dashboards/staging ] ; then
    rm -rf /dashboards/staging
fi
mkdir /dashboards/staging
cd /dashboards/staging
tar zxvf /dashboards/db.tgz
if [ $? -ne 0 ] ; then
    echo "ERROR: Failed to extract /dashboards/db.tgz"
    exit 1
fi

if [ -d /dashboards/prev ] ; then
    rm -rf /dashboards/prev
fi

cd /dashboards

if [ -d /dashboards/top ] ; then
    mv /dashboards/top /dashboards/prev
fi
mv /dashboards/staging/DDP-GrafanaDB*/ /dashboards/top

exit 0

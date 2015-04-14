#!/bin/bash 

rm -rf work
mkdir -p work
cd work

TOMCAT_VERSION="6.0.32"

TOMCAT_DIR="apache-tomcat-${TOMCAT_VERSION}"

TOMCAT_ZIP_FILE="${TOMCAT_DIR}.zip"

TOMCAT_ZIP_URL="https://archive.apache.org/dist/tomcat/tomcat-6/v${TOMCAT_VERSION}/bin/${TOMCAT_ZIP_FILE}"

echo "[shrine/install-tomcat.sh] Downloading Tomcat 6."

wget --no-clobber --no-check-certificate ${TOMCAT_ZIP_URL}

echo "[shine/install-tomcat.sh] Unzipping tomcat to ${SHRINE_TOMCAT_HOME}"

rm -rf ${SHRINE_TOMCAT_HOME}

unzip -q ${TOMCAT_ZIP_FILE}

mkdir -p ${SHRINE_HOME}

mv ${TOMCAT_DIR} ${SHRINE_TOMCAT_HOME}

cd ..

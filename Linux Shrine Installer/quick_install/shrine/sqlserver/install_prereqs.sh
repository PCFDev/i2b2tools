#!/bin/sh

yum -y install wget

yum -y install zip

yum -y install unzip

yum -y install svn

yum clean all

echo "[sqlserver/install_prereqs.sh] NOTE: Shrine saves only query history, not patient data"
echo "[sqlserver/install-prereqs.sh] Please ensure the connection to MSSQL is configured in shrine.rc for SHRINE."
echo "[sqlserver/install-prereqs.sh] IMPORTANT: the account used by the connection needs to have permission to create a new database and user account."

echo "[sqlserver/install-prereqs.sh] Compling the tsql java class to execute jdbc commands against the MSSQL server."

#Complie the java class to execute jdbc scripts
javac ../../tsql.java

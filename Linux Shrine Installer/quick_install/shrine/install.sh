#!/bin/bash

#########
echo "[shrine/install.sh] begin."
#########
#
# SHRINE Installer
#
# Installs shrine using the environment specified in shrine.rc.
# Can run on the same machine as the i2b2 VM or any other box.
# Has been tested against the default i2b2 1.5 setup.
#
# MySQL is the default for shrine since we assume that most SHRINE installations will not be directly on the i2b2 machine.
# Oracle|SQLServer|Other database vendors could easily be used instead.
#
# @see shrine.rc
# @see called scripts.
#
#########
rm ~/shrine.rc
cp shrine.rc ~/shrine.rc
cp ../common.rc ~/common.rc
cp shrine-aliases.sh  ~/shrine-aliases.sh
chmod 640 ~/common.rc
chmod 640 ~/shrine.rc
chmod 750 ~/shrine-aliases.sh
source ./shrine.rc
#########

rm -rf $SHRINE_HOME
rm -rf $HOME/.spin

chmod +x *.sh

#########
echo "[shrine/install.sh] Your SHRINE Environment Variables (see shrine.rc)"

##########
./install_prereqs.sh
./mysql.sh
./install-tomcat.sh
./keystore.sh
./shrine-conf.sh
./tomcat.sh

##########
echo "[shrine/install.sh] Removing installer zips for Tomcat and artifacts that are no longer used after the install process."
##########

df -h

cd work;
du -hs
cd ..

rm -rf work

##########
echo "[shrine/install.sh] Disk Space Free After Install Cleanup"
##########
df -h

##########
echo "[shrine/install.sh] done."
##########

#!/bin/bash

#########
echo "[i2b2/prepare.sh] begin."
#########
#
# I2B2 Configuration for SHRINE
#
# Steps
# 1. hive:     creates the shrine project
# 2. ontology: loads up the shrine ontology
#
#
# @see i2b2.rc
# @see called scripts.
#
#########
rm ~/i2b2.rc
cp i2b2.rc ~/i2b2.rc
cp ../../common.rc ~/common.rc
cp i2b2-aliases.sh  ~
chmod 640 ~/common.rc
chmod 640 ~/i2b2.rc
chmod 750 ~/i2b2-aliases.sh
source ./i2b2.rc
#########

chmod +x *.sh

#########
# echo "[i2b2/prepare.sh] Shutting down JBOSS, just to be on the safe side."
# i2b2_jboss_shutdown
# TODO: make cleaner

#########
echo "[i2b2/prepare.sh] Your I2B2 Environment Variables (see i2b2.rc)"

export | grep I2B2

##########
../install_prereqs.sh
./configure_hive.sh
./configure_pm.sh
./ontology.sh
./disable-update-cells.sh
./post-install.sh

##########
echo "[shrine/prepare.sh] done."
##########

# echo "[i2b2/prepare.sh] Clean start of JBOSS"
# i2b2_jboss_startup

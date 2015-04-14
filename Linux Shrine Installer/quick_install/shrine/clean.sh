#!/bin/bash

#########
#
# SHRINE Clean (uninstall)
#
##########
echo "[shrine/clean.sh] Begin."
##########
source ./shrine.rc
#########


# TODO: cleaner
##########
# echo "[shrine/clean.sh] shutting down tomcat if it is still running."
##########
shrine_shutdown

sleep 3

##########
echo "[shrine/clean.sh] removing shrine home."
##########

rm -rf $SHRINE_HOME

##########
echo "[shrine/clean.sh] removing spin home."
##########

rm -rf $HOME/.spin/

##########
echo "[shrine/clean.sh] removing work directory."
##########

rm -rf work

##########
echo "[shrine/clean.sh] Done."
##########

#!/bin/bash

echo "[i2b2/disable-update-cells.sh] Begin."

#########
# Switching off i2b2 VM feature that will undo changes made by these scripts upon a reboot
#
#########
source ./i2b2.rc
#########

#####
echo "[i2b2/disable-update-cells.sh] Copying modified UpdateCells.java."

cp UpdateCells.java ~tomcat
chown tomcat:tomcat ~tomcat/UpdateCells.java

echo "[i2b2/disable-update-cells.sh] Compiling modified UpdateCells.java."

javac ~tomcat/UpdateCells.java

echo "[i2b2/disable-update-cells.sh] Done."

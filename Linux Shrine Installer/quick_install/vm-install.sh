#!/bin/bash

#########
# SHRINE Installation for existing i2b2 VM users.
#
# This quick install uses defaults.
#
# !!! You MUST CHANGE the default PASSWORDS before using real patient data. !!!
# !!! You MUST CHANGE the default PASSWORDS before using real patient data. !!!
# !!! You MUST CHANGE the default PASSWORDS before using real patient data. !!!
#
# @author Andrew McMurry
# @author Bill Simons
# @author Clint Gilbert
# @author Keith Dwyer
#
# http://open.med.harvard.edu/display/SHRINE
#
# Configuration params
#
# @see i2b2/i2b2.rc
# @see shrine/shrine.rc
#
#########

echo "[vm.sh] Preparing I2B2 for SHRINE"

chmod +x i2b2/*.sh

#ITL added for support for sqlserver
db_server_type=""

if [ $# -gt 0 ]
  then
  db_server_type=$1
fi

if [ "$db_server_type" == "sqlserver" ]
  then

    echo "[vm.sh] MSSQL specified, assuming MSSQL is used for I2B2"

    chmod +x i2b2/sqlserver/*.sh
    cd i2b2/sqlserver


  else
    #echo "only wanting to use MSSQL for now so exiting..."
    #exit 1

#END ITL MOD

    # check for sqlplus, which should be indicative of Oracle support
    which sqlplus > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
      echo "[vm.sh] sqlplus found, assuming Oracle is used"

      chmod +x i2b2/oracle/*.sh
      cd i2b2/oracle
    else
    which psql > /dev/null 2>&1
      if [ $? -eq 0 ]
      then
        echo "[vm.sh] psql found, assuming Postgres is used"

        chmod +x i2b2/postgres/*.sh
        cd i2b2/postgres
      else
        echo "[vm.sh] Neither sqlplus nor psql found, aborting install"
        echo "[vm.sh] If you want to install just SHRINE, run ./shrine/install.sh"
        exit 1
      fi
    fi

  fi #ITL MOD end if

# ./clean.sh
./prepare.sh


cd ../../

echo "[vm.sh] Installing SHRINE "

cd shrine

if [ "$db_server_type" == "sqlserver" ]
  then
  cd sqlserver
fi

chmod +x *.sh
# ./clean.sh
./install.sh
cd ..

echo "[vm.sh] Adding scripts to ~/.bashrc "
echo "source ~/common.rc"         >> ~/.bashrc
echo "source ~/i2b2.rc"           >> ~/.bashrc
echo "source ~/shrine.rc"         >> ~/.bashrc
echo "source ~/i2b2-aliases.sh"   >> ~/.bashrc
echo "source ~/shrine-aliases.sh" >> ~/.bashrc

echo "[vm.sh] Done. "
echo "[vm.sh] ********* "
echo "[vm.sh] You can now start shrine! "
echo "[vm.sh] Run the following commands: "
echo "[vm.sh] $ source ~/.bashrc "
echo "[vm.sh] $ shrine_startup "
echo "[vm.sh] ********* "

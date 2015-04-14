#!/bin/sh
# -----------------------------------------------------------------------------------------------------------
#
# SPIN Key and Sef-Signed Certificate Generator
#
# Copyright (c) 2002 Harvard Medical School and Massachusetts General Hospital, All Rights Reserved.
#
# -----------------------------------------------------------------------------------------------------------
##########
source ~/shrine.rc
##########

if [ ! `which keytool` ]; then
    if [ -f /usr/java/default/bin/keytool ]; then
      ln -s /usr/java/default/bin/keytool /usr/bin/keytool
    else
      echo "KEYTOOL NOT FOUND AT /usr/java/default/bin/keytool; EXPECT SUBSEQUENT FAILURES"
    fi
fi

mode=$1

#
# Setup Local Configuration
#
    case "$mode" in
      '-generate')

     # Generate the Server Key

	 keytool -genkeypair -keysize 2048 -alias $KEYSTORE_ALIAS -dname "CN=$KEYSTORE_ALIAS, OU=$KEYSTORE_HUMAN, O=SHRINE Network, L=$KEYSTORE_CITY, S=$KEYSTORE_STATE, C=$KEYSTORE_COUNTRY" -keyalg RSA -keypass $KEYSTORE_PASSWORD -storepass $KEYSTORE_PASSWORD -keystore $KEYSTORE_FILE -validity 7300

	 # Verify that the key was stored

	 keytool -list -v -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD

	 # Export key to a Self-Signed Certificate

	 keytool -export -alias $KEYSTORE_ALIAS -storepass $KEYSTORE_PASSWORD -file $KEYSTORE_ALIAS.cer -keystore $KEYSTORE_FILE

      ;;

      '-import')
	 # Import other Server's Certificate
         
         # keytool -delete -alias $2 -keystore $KEYSTORE_FILE -keypass $KEYSTORE_PASSWORD
      
	 keytool -import -v -trustcacerts -alias $2 -file $2 -keystore $KEYSTORE_FILE  -keypass $KEYSTORE_PASSWORD  -storepass $KEYSTORE_PASSWORD

	 # Verify that Certificate was Imported

    echo
    echo "******************************** YOUR KEYSTORE ***************************"
    echo
    echo
    keytool -list -v -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD
    echo
    echo "******************************** YOUR KEYSTORE ***************************"
    echo

      ;;

      *)
	# Usage
        echo "usage:" 
	echo
	echo "ssl_keytool.sh -generate"
	echo       "(no parameters needed)"
	echo
	echo "keystore.sh -import <fully qualified name> "
	echo       "e.g. ssl_keytool.sh -import vsl-bwh.partners.org"
	echo 
	echo
    esac

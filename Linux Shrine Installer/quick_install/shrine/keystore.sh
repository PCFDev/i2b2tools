echo "[shrine/keystore.sh]"

#########
# SSL and Networking setup
#
# Generates SSL certificate
# @see ssl_keytool.sh
#
#########
source ./shrine.rc

#  TODO: use work directory
#########

echo "[shrine/keystore.sh] Generating a keystore pair (public key, private key) "

./ssl_keytool.sh -generate
mv $KEYSTORE_ALIAS.cer ${SHRINE_HOME}/.

#####
echo "[shrine/keystore.sh] Done."

echo 
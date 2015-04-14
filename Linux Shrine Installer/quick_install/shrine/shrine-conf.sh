echo "[shrine/shrine-conf.sh] Begin."

#########
# SHRINE Setup
#
# Sets up shrine.conf, Shrine's main config file.
#
#########

source ./shrine.rc

interpolate_file ./skel/shrine.conf "I2B2_CRC_IP" "$I2B2_CRC_IP" | \
interpolate "I2B2_PM_IP" "$I2B2_PM_IP" | \
interpolate "I2B2_ONT_IP" "$I2B2_ONT_IP" | \
interpolate "SHRINE_NODE_NAME" "$SHRINE_NODE_NAME" | \
interpolate "KEYSTORE_FILE" "$KEYSTORE_FILE" | \
interpolate "KEYSTORE_PASSWORD" "$KEYSTORE_PASSWORD" | \
interpolate "KEYSTORE_ALIAS" "$KEYSTORE_ALIAS" | \
interpolate "SHRINE_ADAPTER_I2B2_DOMAIN" "$SHRINE_ADAPTER_I2B2_DOMAIN" | \
interpolate "SHRINE_ADAPTER_I2B2_USER" "$SHRINE_ADAPTER_I2B2_USER" | \
interpolate "SHRINE_ADAPTER_I2B2_PASSWORD" "$SHRINE_ADAPTER_I2B2_PASSWORD" | \
interpolate "SHRINE_ADAPTER_I2B2_PROJECT" "$SHRINE_ADAPTER_I2B2_PROJECT" > $SHRINE_CONF_FILE

echo "[shrine/shrine-conf.sh] Done."

echo "[shrine/tomcat.sh] Begin."

#########
# SHRINE Tomcat Setup
#
# Downloads all the necesary SHRINE webapp components and configures them.
#
# Basically provides grep/replace on template files
#
# @see skel/tomcat_server.xml   = tomcat server config file
# @see skel/shrine.xml.vm       = webapp configuration
# @see skel/i2b2_config_data.js = client connection to the PM
# @see skel/cell_config_data.js = client connection to the CRC
#
#########
source ~/shrine.rc
source ~/shrine-aliases.sh

mkdir -p $SHRINE_HOME
mkdir -p work; cd work

#########

iptables -I INPUT 9 -m state --state NEW -m tcp -p tcp --dport ${SHRINE_PORT} -j ACCEPT
iptables -I INPUT 9 -m state --state NEW -m tcp -p tcp --dport ${SHRINE_SSL_PORT} -j ACCEPT

service iptables save
service iptables restart

#########

NEXUS_URL_BASE=http://repo.open.med.harvard.edu/nexus/content/groups/public/net/shrine/

SHRINE_WAR_ARTIFACT_ID=shrine-war
SHRINE_WAR_FILE=${SHRINE_WAR_ARTIFACT_ID}-${SHRINE_VERSION}.war
SHRINE_WAR_FILE_FINAL_NAME=shrine.war
SHRINE_WAR_URL=${NEXUS_URL_BASE}/${SHRINE_WAR_ARTIFACT_ID}/${SHRINE_VERSION}/${SHRINE_WAR_FILE}

SHRINE_PROXY_ARTIFACT_ID=shrine-proxy
SHRINE_PROXY_WAR_FILE=${SHRINE_PROXY_ARTIFACT_ID}-${SHRINE_VERSION}.war
SHRINE_PROXY_WAR_FILE_FINAL_NAME=shrine-proxy.war
SHRINE_PROXY_WAR_URL=${NEXUS_URL_BASE}/${SHRINE_PROXY_ARTIFACT_ID}/${SHRINE_VERSION}/${SHRINE_PROXY_WAR_FILE}

#####
echo "[shrine/tomcat.sh] Downloading shrine web application"

wget --no-clobber ${SHRINE_WAR_URL}

#####

echo "[shrine/tomcat.sh] Downloading shrine war file"

cp ${SHRINE_WAR_FILE} ${SHRINE_TOMCAT_HOME}/webapps/${SHRINE_WAR_FILE_FINAL_NAME}

#####
echo "[shrine/tomcat.sh] Downloading and configuring shrine proxy"

wget --no-clobber  ${SHRINE_PROXY_WAR_URL}

cp ${SHRINE_PROXY_WAR_FILE} $SHRINE_TOMCAT_HOME/webapps/${SHRINE_PROXY_WAR_FILE_FINAL_NAME}

#####
echo "[shrine/tomcat.sh] Downloading shrine web client (from svn release)"

rm -rf shrine-webclient
svn export --quiet ${SHRINE_SVN_URL_BASE}/code/shrine-webclient/ shrine-webclient

#####
echo "[shrine/tomcat.sh] Downloading AdapterMappings.xml for the default i2b2 dataset."

ADAPTER_MAPPINGS_FILE_URL=`perl ../determine-adapter-mappings-url.pl`

wget --no-clobber -O AdapterMappings.xml ${ADAPTER_MAPPINGS_FILE_URL}
cp AdapterMappings.xml ${SHRINE_TOMCAT_LIB}/AdapterMappings.xml

#####

cd ..
./tomcat_configure_server_xml.sh
cd work

require "${SHRINE_IP}" "SHRINE_IP must be set"
require "${SHRINE_SSL_PORT}" "SHRINE_SSL_PORT must be set"
require "${SHRINE_PORT}" "SHRINE_PORT must be set"
require "${SHRINE_MYSQL_USER}" "SHRINE_MYSQL_USER must be set"
require "${SHRINE_MYSQL_PASSWORD}" "SHRINE_MYSQL_PASSWORD must be set"
require "${SHRINE_MYSQL_HOST}" "SHRINE_MYSQL_HOST must be set"
require "${SHRINE_NODE_NAME}" "SHRINE_NODE_NAME must be set"
require "${SHRINE_ADAPTER_I2B2_DOMAIN}" "SHRINE_ADAPTER_I2B2_DOMAIN must be set"
require "${SHRINE_ADAPTER_I2B2_USER}" "SHRINE_ADAPTER_I2B2_USER must be set"
require "${SHRINE_ADAPTER_I2B2_PASSWORD}" "SHRINE_ADAPTER_I2B2_PASSWORD must be set"
require "${SHRINE_ADAPTER_I2B2_PROJECT}" "SHRINE_ADAPTER_I2B2_PROJECT must be set"
require "${KEYSTORE_FILE}" "KEYSTORE_FILE must be set"
require "${KEYSTORE_PASSWORD}" "KEYSTORE_PASSWORD must be set"

#####
echo "[shrine/tomcat.sh] Configuring shrine.xml"

mkdir -p ${SHRINE_TOMCAT_HOME}/conf/Catalina/localhost

interpolate_file ../skel/shrine.xml "SHRINE_MYSQL_USER" "$SHRINE_MYSQL_USER" | \
interpolate "SHRINE_MYSQL_PASSWORD" "$SHRINE_MYSQL_PASSWORD" | \
interpolate "SHRINE_MYSQL_HOST" "$SHRINE_MYSQL_HOST" > $SHRINE_TOMCAT_APP_CONF

#####
echo "[shrine/tomcat.sh] Configuring shrine webclient"

cp shrine-webclient/i2b2_config_data.js shrine-webclient/i2b2_config_data.js.default 
cp shrine-webclient/js-i2b2/cells/SHRINE/cell_config_data.js   shrine-webclient/js-i2b2/cells/SHRINE/cell_config_data.js.default

interpolate_file ../skel/i2b2_config_data.js "I2B2_PM_IP" "$I2B2_PM_IP" | \
interpolate "I2B2_DOMAIN_ID" "$I2B2_DOMAIN_ID" | \
interpolate "SHRINE_NODE_NAME" "$SHRINE_NODE_NAME" > shrine-webclient/i2b2_config_data.js

interpolate_file ../skel/cell_config_data.js "SHRINE_IP" "$SHRINE_IP" | \
interpolate "SHRINE_SSL_PORT" "$SHRINE_SSL_PORT" > shrine-webclient/js-i2b2/cells/SHRINE/cell_config_data.js

cp -a shrine-webclient ${SHRINE_TOMCAT_HOME}/webapps/

#####
echo "[shrine/tomcat.sh] Done."

chmod +x $SHRINE_TOMCAT_HOME/bin/*.sh

echo "[shrine/tomcat.sh] You can now start shrine tomcat"
alias shrine_startup
cd ..

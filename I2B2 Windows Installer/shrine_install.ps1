. .\functions.ps1
. .\common.ps1

#Stop-Service Tomcat8

$ShrineQuickInstallUrl = "$_SHRINE_SVN_URL_BASE/code/install/i2b2-1.7/"

$ShrineWar = "shrine-war-$_SHRINE_VERSION.war"
$ShrineWarURL = "$_NEXUS_URL_BASE/shrine-war/$_SHRINE_VERSION/$ShrineWar"

$ShrineProxy = "shrine-proxy-$_SHRINE_VERSION.war"
$ShrineProxyURL = "$_NEXUS_URL_BASE/shrine-proxy/$_SHRINE_VERSION/$ShrineProxy"

#Make Temporary Shrine Setup Directory
mkdir $_SHRINE_HOME\setup
$_SHRINE_SETUP = "$_SHRINE_HOME\setup"

mkdir $_SHRINE_SETUP\ready


#Download Subversion
$SVNUrl = "http://downloads.sourceforge.net/project/win32svn/1.8.11/apache22/svn-win32-1.8.11.zip?"
Invoke-WebRequest  $SVNUrl -OutFile $_SHRINE_SETUP\subversion.zip -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer
unzip $_SHRINE_SETUP\subversion.zip $_SHRINE_SETUP\svn

echo "downloading shrine and shrine-proxy war files"
#Download shrine.war and shrine-proxy.war to tomcat
Invoke-WebRequest $ShrineWarURL  -OutFile $_SHRINE_SETUP\shrine.war
Invoke-WebRequest $ShrineProxyURL  -OutFile $_SHRINE_SETUP\shrine-proxy.war

echo "downloading shrine-webclient to tomcat"
#run to copy shrine-webclient to webapps folder in tomcat
& "$_SHRINE_SETUP\svn\svn-win32-1.8.11\bin\svn.exe" checkout $_SHRINE_SVN_URL_BASE/code/shrine-webclient/  $_SHRINE_SETUP\shrine-webclient > $null

$ShrineAdapterMappingsURL = "$_SHRINE_SVN_URL_BASE/ontology/SHRINE_Demo_Downloads/AdapterMappings_i2b2_DemoData.xml"

echo "downloading AdapterMappings.xml file to tomcat"
Invoke-WebRequest $ShrineAdapterMappingsURL  -OutFile $_SHRINE_SETUP\AdapterMappings.xml

#
#
#


#Interpolate tomcat_server_8.xml with common settings
interpolate_file .\shrine\skel\tomcat_server_8.xml "SHRINE_PORT" $_SHRINE_PORT |
    interpolate "SHRINE_SSL_PORT" $_SHRINE_SSL_PORT | 
    interpolate "KEYSTORE_FILE" "$_SHRINE_HOME\shrine.keystore" |
    interpolate "KEYSTORE_PASSWORD" "changeit" | Out-File -Encoding utf8 $_SHRINE_SETUP\ready\server.xml

#Interpolate cell_config_data.js with common settings
interpolate_file .\shrine\skel\cell_config_data.js "SHRINE_IP" $_SHRINE_IP |
    interpolate "SHRINE_SSL_PORT" $_SHRINE_SSL_PORT > $_SHRINE_SETUP\ready\cell_config_data.js

#Interpolate shrine.xml with common settings
interpolate_file .\shrine\skel\shrine.xml "SHRINE_SQL_USER" $_SHRINE_MSSQL_USER |
    interpolate "SHRINE_SQL_PASSWORD" $_SHRINE_MSSQL_PASSWORD |
    interpolate "SHRINE_SQL_SERVER" $_SHRINE_MSSQL_SERVER |
    interpolate "SHRINE_SQL_DB" $_SHRINE_MSSQL_DB > $_SHRINE_SETUP\ready\shrine.xml

#Interpolate i2b2_config_data.js with common settings
interpolate_file .\shrine\skel\i2b2_config_data.js "I2B2_PM_IP" $_I2B2_PM_IP |
    interpolate "SHRINE_NODE_NAME" $_SHRINE_NODE_NAME > $_SHRINE_SETUP\ready\i2b2_config_data.js

#Interpolate shrine.conf with common settings
interpolate_file .\shrine\skel\shrine.conf "I2B2_PM_IP" $_I2B2_PM_IP | interpolate "I2B2_ONT_IP" $_I2B2_ONT_IP |
    interpolate "SHRINE_ADAPTER_I2B2_DOMAIN" $_SHRINE_ADAPTER_I2B2_DOMAIN |
    interpolate "SHRINE_ADAPTER_I2B2_USER" $_SHRINE_ADAPTER_I2B2_USER | 
    interpolate "SHRINE_ADAPTER_I2B2_PASSWORD" $_SHRINE_ADAPTER_I2B2_PASSWORD |
    interpolate "SHRINE_ADAPTER_I2B2_PROJECT" $_SHRINE_ADAPTER_I2B2_PROJECT |
    interpolate "I2B2_CRC_IP" $_I2B2_CRC_IP | interpolate "SHRINE_NODE_NAME" $_SHRINE_NODE_NAME |
    interpolate "KEYSTORE_FILE" (escape $_KEYSTORE_FILE) | interpolate "KEYSTORE_PASSWORD" $_KEYSTORE_PASSWORD |
    interpolate "KEYSTORE_ALIAS" $_KEYSTORE_ALIAS > $_SHRINE_SETUP\ready\shrine.conf

#Copy relevant files to proper locations
mkdir $_SHRINE_TOMCAT_HOME\webapps\shrine-webclient
Copy-Item $_SHRINE_SETUP\shrine-webclient\* -Destination $_SHRINE_TOMCAT_HOME\webapps\shrine-webclient -Container -Recurse
Copy-Item $_SHRINE_SETUP\ready\server.xml $_SHRINE_TOMCAT_SERVER_CONF
Copy-Item $_SHRINE_SETUP\ready\shrine.xml $_SHRINE_TOMCAT_APP_CONF
Copy-Item $_SHRINE_SETUP\ready\shrine.conf $_SHRINE_CONF_FILE
Copy-Item $_SHRINE_SETUP\ready\cell_config_data.js $_SHRINE_TOMCAT_HOME\webapps\shrine-webclient\js-i2b2\cells\SHRINE\cell_config_data.js
Copy-Item $_SHRINE_SETUP\ready\i2b2_config_data.js $_SHRINE_TOMCAT_HOME\webapps\shrine-webclient\i2b2_config_data.js
Copy-Item $_SHRINE_SETUP\shrine.war $_SHRINE_TOMCAT_HOME\webapps\shrine.war
Copy-Item $_SHRINE_SETUP\shrine-proxy.war $_SHRINE_TOMCAT_HOME\webapps\shrine-proxy.war
Copy-Item $_SHRINE_SETUP\AdapterMappings.xml $_SHRINE_TOMCAT_LIB
Copy-Item .\shrine\skel\sqljdbc4.jar $_SHRINE_TOMCAT_LIB\sqljdbc4.jar


#Remove Shrine Setup Directory
#Remove-Item $_SHRINE_HOME\setup\* -Recurse -Force
Remove-Item $_SHRINE_HOME\setup -Recurse -Force

Restart-Service Tomcat8
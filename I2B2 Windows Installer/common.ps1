Write-Host "importing configuration values"

$_SHRINE_VERSION = "1.18.2"

$_I2B2_DOMAIN_ID = "i2b2demo"

$_SHRINE_IP = "localhost"
$_SHRINE_MSSQL_SERVER = "localhost"

$_NEXUS_URL_BASE = "http://repo.open.med.harvard.edu/nexus/content/groups/public/net/shrine"
$_SHRINE_SVN_URL_BASE = "https://open.med.harvard.edu/svn/shrine/releases/$_SHRINE_VERSION"

$_I2B2_IP_DEFAULT = "localhost:9090"

$_I2B2_PM_IP = $_I2B2_IP_DEFAULT
$_I2B2_ONT_IP = $_I2B2_IP_DEFAULT
$_I2B2_CRC_IP = $_I2B2_IP_DEFAULT

$_SHRINE_PORT = "6060"
$_SHRINE_SSL_PORT = "6443"



#Shrine, including the Tomcat application server that Shrine runs in, will be installed here.
$_SHRINE_HOME = (Get-Item $env:CATALINA_HOME).Parent.FullName

#The directory containing the Tomcat application server that Shrine runs in.
$_SHRINE_TOMCAT_HOME = "$_SHRINE_HOME\tomcat"

#A directory on Tomcat'sclasspath, from which shrine.conf will be loaded 
$_SHRINE_TOMCAT_LIB = "$_SHRINE_TOMCAT_HOME\lib"

#The primary Shrine config file
$_SHRINE_CONF_FILE = "$_SHRINE_TOMCAT_LIB\shrine.conf"

#Tomcat's main configuration file.
$_SHRINE_TOMCAT_SERVER_CONF = "$_SHRINE_TOMCAT_HOME\conf\server.xml"

#The location of the Shrine web app's context configuration file.
$_SHRINE_TOMCAT_APP_CONF = "$_SHRINE_TOMCAT_HOME\conf\Catalina\localhost\shrine.xml"

#The human-readable name of the Shrine node being installed.  This string will appear in the web UI as a label on a source of query results.
$_SHRINE_NODE_NAME = "Harvard Affiliated Teaching Hospital"

#The cryptographic keystore file used by Shrine.
$_KEYSTORE_FILE = "$_SHRINE_HOME\shrine.keystore"

#Default password for the keystore
$_KEYSTORE_PASSWORD = "changeit"

#Human-readable name for the cryptographic certificate generated for this Shrine node.
$_KEYSTORE_ALIAS = $_SHRINE_IP

#Human-readable name for the cryptographic certificate generated for this Shrine node.
$_KEYSTORE_HUMAN = $_SHRINE_NODE_NAME

#City where the node resides; will be included in generated cryptographic certificate.
$_KEYSTORE_CITY = "Boston"

#State where the node resides; will be included in generated cryptographic certificate.
$_KEYSTORE_STATE = "MA"

#Country where the node resides; will be included in generated cryptographic certificate.
$_KEYSTORE_COUNTRY = "US"

#The host at which MySQL is accessible.  MySQL is needed by Shrine for logging purposes.
$_SHRINE_MYSQL_HOST = "localhost"

#The MySQL user Shrine should log in as.
$_SHRINE_MYSQL_USER = "shrine"

#The password for the MySQL user that Shrine should log in as.
$_SHRINE_MYSQL_PASSWORD = "demouser"

#The database name for the MSSQL server instance
$_SHRINE_MSSQL_DB = "shrine"

#The MSSQL user Shrine should log in as.
$_SHRINE_MSSQL_USER = "shrine_installer"

#The password for the MSSSQL user that Shrine should log in as.
$_SHRINE_MSSQL_PASSWORD = "demouser"

#The i2b2 user Shrine should use when making queries to an i2b2 hive.
$_SHRINE_ADAPTER_I2B2_USER = "demo"

#The password for the i2b2 user Shrine should use when making queries to an i2b2 hive.
$_SHRINE_ADAPTER_I2B2_PASSWORD = "demouser"

#The i2b2 project Shrine should use when making queries to an i2b2 hive.
$_SHRINE_ADAPTER_I2B2_PROJECT = "Demo"

#The i2b2 domain Shrine should use when making queries to an i2b2 hive.
#NB: This needs to match I2B2_DOMAIN_ID:(
$_SHRINE_ADAPTER_I2B2_DOMAIN = "i2b2demo"

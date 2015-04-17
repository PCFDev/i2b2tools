﻿$JBOSS_ADDRESS = "0.0.0.0"
$JBOSS_PORT = "9090"
$JBOSS_ADMIN = "jbossAdmin"
$JBOSS_PASS = "jbossP@ss"

#Location of the i2b2 web services
$DEFAULT_I2B2_SERVICE_URL="http://localhost:9090/i2b2/services"
$PM_SERVICE_URL="$DEFAULT_I2B2_SERVICE_URL/PMService/getServices"
$CRC_SERVICE_URL="$DEFAULT_I2B2_SERVICE_URL/QueryToolService"
$FR_SERVICE_URL="$DEFAULT_I2B2_SERVICE_URL/FRService"
$ONT_SERVICE_URL="$DEFAULT_I2B2_SERVICE_URL/OntologyService"

#Service account used by i2b2 software
$I2B2_SERVICEACCOUNT_USER="AGG_SERVICE_ACCOUNT"
$I2B2_SERVICEACCOUNT_PASS="demouser"

#Database configuration
$DEFAULT_DB_URL="jdbc:sqlserver://localhost:1433"
$DEFAULT_DB_DRIVER="com.microsoft.sqlserver.jdbc.SQLServerDriver"
$DEFAULT_DB_JAR_FILE="sqljdbc4.jar"
$DEFAULT_DB_TYPE="SQLServer"
$DEFAULT_DB_USER=$null #<== THIS IS NOT SET
$DEFAULT_DB_PASS="demouser"

#Cell configuration
$HIVE_DB_DRIVER=$DEFAULT_DB_DRIVER
$HIVE_DB_JAR_FILE=$DEFAULT_DB_JAR_FILE
$HIVE_DB_URL=$DEFAULT_DB_URL
$HIVE_DB_SCHEMA="i2b2hive.dbo"
$HIVE_DB_USER="i2b2hive"
$HIVE_DB_PASS=$DEFAULT_DB_PASS

$PM_DB_DRIVER=$DEFAULT_DB_DRIVER
$PM_DB_JAR_FILE=$DEFAULT_DB_JAR_FILE
$PM_DB_URL=$DEFAULT_DB_URL
$PM_DB_SCHEMA="i2b2pm.dbo"
$PM_DB_USER="i2b2pm"
$PM_DB_PASS=$DEFAULT_DB_PASS

$ONT_DB_DRIVER=$DEFAULT_DB_DRIVER
$ONT_DB_JAR_FILE=$DEFAULT_DB_JAR_FILE
$ONT_DB_URL=$DEFAULT_DB_URL
$ONT_DB_SCHEMA="i2b2metadata.dbo"
$ONT_DB_USER="i2b2metadata"
$ONT_DB_PASS=$DEFAULT_DB_PASS

$CRC_DB_DRIVER=$DEFAULT_DB_DRIVER
$CRC_DB_JAR_FILE=$DEFAULT_DB_JAR_FILE
$CRC_DB_URL=$DEFAULT_DB_URL
$CRC_DB_SCHEMA="i2b2demodata.dbo"
$CRC_DB_USER="i2b2demodata"
$CRC_DB_PASS=$DEFAULT_DB_PASS

$WORK_DB_DRIVER=$DEFAULT_DB_DRIVER
$WORK_DB_JAR_FILE=$DEFAULT_DB_JAR_FILE
$WORK_DB_URL=$DEFAULT_DB_URL
$WORK_DB_SCHEMA="i2b2workdata.dbo"
$WORK_DB_USER="i2b2workdata"
$WORK_DB_PASS=$DEFAULT_DB_PASS

$IM_DB_DRIVER=$DEFAULT_DB_DRIVER
$IM_DB_JAR_FILE=$DEFAULT_DB_JAR_FILE
$IM_DB_URL=$DEFAULT_DB_URL
$IM_DB_SCHEMA="i2b2imdata.dbo"
$IM_DB_USER="i2b2imdata"
$IM_DB_PASS=$DEFAULT_DB_PASS



echo "Extracting i2b2 source..."
unzip $__sourceCodeZipFile $__sourceCodeRootFolder $true
echo "Source extracted to $__sourceCodeRootFolder"

if(!(Test-Path $__sourceCodeRootFolder))
{
    Throw "Source not extracted"
}

echo "Installing server common"
cd $__sourceCodeRootFolder\edu.harvard.i2b2.server-common

cp build.properties build.properties.bak

interpolate_file $__skelDirectory\i2b2\server-common\build.properties JBOSS_HOME (escape $env:JBOSS_HOME) | sc build.properties

ant clean dist deploy jboss_pre_deployment_setup

cd ..
echo "Server common installed"

echo "Installing PM Cell"
cd edu.harvard.i2b2.pm

cp build.properties build.properties.bak

interpolate_file $__skelDirectory\i2b2\pm\build.properties JBOSS_HOME (escape $env:JBOSS_HOME) | sc build.properties

cp etc\jboss\pm-ds.xml etc\jboss\pm-ds.xml.bak

interpolate_file $__skelDirectory\i2b2\pm\pm-ds.xml PM_DB_URL $PM_DB_URL | 
    interpolate PM_DB_USER $PM_DB_USER |
    interpolate PM_DB_PASS $PM_DB_PASS |
    sc etc\jboss\pm-ds.xml


ant -file master_build.xml clean build-all deploy

cd ..
echo "PM Cell Installed"

echo "Installing ONT Cell"
cd edu.harvard.i2b2.ontology

#cp build.properties build.properties.bak

interpolate_file $__skelDirectory\i2b2\ontology\build.properties JBOSS_HOME (escape $env:JBOSS_HOME) | sc build.properties

interpolate_file $__skelDirectory\i2b2\ontology\ontology_application_directory.properties JBOSS_HOME (escape $env:JBOSS_HOME) | 
    sc etc/spring/ontology_application_directory.properties

interpolate_file $__skelDirectory\i2b2\ontology\ontology.properties ONT_METADATA_DB_SCHEMA $ONT_METADATA_DB_SCHEMA | 
    interpolate PM_SERVICE_URL $PM_SERVICE_URL |
    interpolate CRC_SERVICE_URL $CRC_SERVICE_URL |
    interpolate FR_SERVICE_URL $FR_SERVICE_URL |
    interpolate I2B2_SERVICEACCOUNT_USER $I2B2_SERVICEACCOUNT_USER |
    interpolate I2B2_SERVICEACCOUNT_PASS $I2B2_SERVICEACCOUNT_PASS |
    sc etc/spring/ontology.properties

#cp etc\jboss\ont-ds.xml etc\jboss\ont-ds.xml.bak

interpolate_file $__skelDirectory\i2b2\ontology\ont-ds.xml HIVE_DB_URL $HIVE_DB_URL | 
    interpolate HIVE_DB_USER $HIVE_DB_USER |
    interpolate HIVE_DB_PASS $HIVE_DB_PASS |
    interpolate ONT_DB_URL $ONT_DB_URL |
    interpolate ONT_DB_USER $ONT_DB_USER |
    interpolate ONT_DB_PASS $ONT_DB_PASS |
    sc etc\jboss\ont-ds.xml


ant -file master_build.xml clean build-all deploy

cd ..
echo "ONT Cell Installed"




echo "Install Admin Site  -- NOT DONE"
echo "Install WebClient Site  -- NOT DONE"

cd $__currentDirectory
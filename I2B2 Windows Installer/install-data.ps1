echo "Starting i2b2 Data Installation"

function installCrc{

    cd Crcdata

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $CRC_DB_USER |
        interpolate DB_PASS $CRC_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $CRC_DB_DRIVER |
        interpolate DB_URL $CRC_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties
    
    echo "Installing CRC Tables"
    ant –file data_build.xml create_crcdata_tables_release_1-7

    echo "Installing CRC Stored Procedures"
    ant –file data_build.xml create_procedures_release_1-7

    if($InstallDemoData -eq $true){
        echo "Loading CRC demo data"
        ant –file data_build.xml db_demodata_load_data
    }
    
    cd ..
    echo "CRC Data Installed"

}

function installHive{
    cd Hivedata

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $HIVE_DB_USER |
        interpolate DB_PASS $HIVE_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $HIVE_DB_DRIVER |
        interpolate DB_URL $HIVE_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing Hive Tables"
    ant –file data_build.xml create_hivedata_tables_release_1-7
  
    if($InstallDemoData -eq $true){
        echo "Loading Hive demo data"
        ant –file data_build.xml db_hivedata_load_data
    }

    cd ..
    echo "Hive Data Installed"
}

function installIM{

    cd Imdata

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $IM_DB_USER |
        interpolate DB_PASS $IM_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $IM_DB_DRIVER |
        interpolate DB_URL $IM_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing IM Tables"
    ant –file data_build.xml create_imdata_tables_release_1-7
    
    if($InstallDemoData -eq $true){
        echo "Loading IM demo data"
        ant –file data_build.xml db_imdata_load_data
    }

    cd ..
    echo "IM Data Installed"
}

function installOnt{

    cd Metadata

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $ONT_DB_USER |
        interpolate DB_PASS $ONT_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $ONT_DB_DRIVER |
        interpolate DB_URL $ONT_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing ONT Tables"
    ant –file data_build.xml create_metadata_tables_release_1-7
    
    if($InstallDemoData -eq $true){
        echo "Loading ONT demo data"
        ant –file data_build.xml db_metadata_load_data
    }

    cd ..
    echo "Metadata Data Installed"
}

function installPM{

    cd Pmdata


    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $PM_DB_USER |
        interpolate DB_PASS $PM_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $PM_DB_DRIVER |
        interpolate DB_URL $PM_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing PM Tables"
    ant –file data_build.xml create_pmdata_tables_release_1-7

    echo "Installing PM Triggers"
    ant –file data_build.xml create_triggers_release_1-7
    
    if($InstallDemoData -eq $true){
        echo "Loading PM demo data"
        ant –file data_build.xml db_pmdata_load_data
    }

    cd ..
    echo "PM Data Installed"
}

function installWork{

    cd Workdata

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $WORK_DB_USER |
        interpolate DB_PASS $WORK_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $WORK_DB_DRIVER |
        interpolate DB_URL $WORK_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing Work Tables"
    ant –file data_build.xml create_workdata_tables_release_1-7
  
    if($InstallDemoData -eq $true){
        echo "Loading Work demo data"
        ant –file data_build.xml db_workdata_load_data
    }

    cd ..
    echo "Work Data Installed"
}

installCrc
installHive
installIM
installOnt
installPM
installWork

echo "i2b2 Data Installation Completed"
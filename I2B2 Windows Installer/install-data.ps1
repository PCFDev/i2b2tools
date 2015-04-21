﻿echo "Starting i2b2 Data Installation"

function installCrc{

    cd Crcdata
    $buildFile = (Get-Item -Path ".\" -Verbose).FullName + "\data_build.xml"

    #HACK to get ant to run   
    #cp data_build.xml build.xml

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $CRC_DB_USER |
        interpolate DB_PASS $CRC_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $CRC_DB_DRIVER |
        interpolate DB_URL $CRC_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties
    
    echo "Installing CRC Tables"    
    ant -f "$buildFile" create_crcdata_tables_release_1-7

    echo "Installing CRC Stored Procedures"
    ant -f "$buildFile" create_procedures_release_1-7

    if($InstallDemoData -eq $true){
        echo "Loading CRC demo data"
        ant -f "$buildFile" db_demodata_load_data        
    }
    
    cd ..
    echo "CRC Data Installed"

}

function installHive{
    cd Hivedata
    $buildFile = (Get-Item -Path ".\" -Verbose).FullName + "\data_build.xml"

    #HACK to get ant to run   
    #cp data_build.xml build.xml

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $HIVE_DB_USER |
        interpolate DB_PASS $HIVE_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $HIVE_DB_DRIVER |
        interpolate DB_URL $HIVE_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing Hive Tables"

    ant -f "$buildFile" create_hivedata_tables_release_1-7


    if($InstallDemoData -eq $true){
       echo "Loading Hive demo data"

       ant -f "$buildFile" db_hivedata_load_data
    }

    cd ..
    echo "Hive Data Installed"
}

function installIM{

    cd Imdata
    $buildFile = (Get-Item -Path ".\" -Verbose).FullName + "\data_build.xml"

    #HACK to get ant to run   
    #cp data_build.xml build.xml

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $IM_DB_USER |
        interpolate DB_PASS $IM_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $IM_DB_DRIVER |
        interpolate DB_URL $IM_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing IM Tables"
    ant -f "$buildFile" create_imdata_tables_release_1-7
    
    if($InstallDemoData -eq $true){
        echo "Loading IM demo data"
        ant -f "$buildFile"  db_imdata_load_data
    }

    cd ..
    echo "IM Data Installed"
}

function installOnt{

    cd Metadata
    $buildFile = (Get-Item -Path ".\" -Verbose).FullName + "\data_build.xml"

    #HACK to get ant to run   
    #cp data_build.xml build.xml


    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $ONT_DB_USER |
        interpolate DB_PASS $ONT_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $ONT_DB_DRIVER |
        interpolate DB_URL $ONT_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing ONT Tables"
    ant -f "$buildFile" create_metadata_tables_release_1-7
    
    if($InstallDemoData -eq $true){
        echo "Loading ONT demo data"
        ant -f "$buildFile" db_metadata_load_data
    }

    cd ..
    echo "Metadata Data Installed"
}

function installPM{

    cd Pmdata        
    $buildFile = (Get-Item -Path ".\" -Verbose).FullName + "\data_build.xml"

    #HACK to get ant to run   
    #cp data_build.xml build.xml


    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $PM_DB_USER |
        interpolate DB_PASS $PM_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $PM_DB_DRIVER |
        interpolate DB_URL $PM_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing PM Tables"

    ant -f "$buildFile" create_pmdata_tables_release_1-7

    echo "Installing PM Triggers"
    

    ant -f "$buildFile" create_triggers_release_1-7
    
    if($InstallDemoData -eq $true){
        echo "Loading PM demo data"
        ant -f "$buildFile" db_pmdata_load_data
    }

    cd ..
    echo "PM Data Installed"
}

function installWork{

    cd Workdata
    
    $buildFile = (Get-Item -Path ".\" -Verbose).FullName + "\data_build.xml"

    
    #HACK to get ant to run   
    #cp data_build.xml build.xml

    interpolate_file $__skelDirectory\i2b2\data\db.properties DB_TYPE $DEFAULT_DB_TYPE |
        interpolate DB_USER $WORK_DB_USER |
        interpolate DB_PASS $WORK_DB_PASS |
        interpolate DB_SERVER $DEFAULT_DB_SERVER |
        interpolate DB_DRIVER $WORK_DB_DRIVER |
        interpolate DB_URL $WORK_DB_URL |
        interpolate I2B2_PROJECT_NAME $I2B2_PROJECT_NAME |
        sc db.properties

    echo "Installing Work Tables"
    #ant create_workdata_tables_release_1-7

    ant -f "$buildFile" create_workdata_tables_release_1-7
  
    if($InstallDemoData -eq $true){
        echo "Loading Work demo data"
        ant -f "$buildFile" db_workdata_load_data
    }

    cd ..
    echo "Work Data Installed"
}


echo "Verifing conenction to database server"

try{
    $conn = New-Object System.Data.SqlClient.SqlConnection
    $conn.ConnectionString = "Server=$DEFAULT_DB_SERVER;Database=master;Uid=$DEFAULT_DB_ADMIN_USER;Pwd=$DEFAULT_DB_ADMIN_PASS;"
    #$conn.ConnectionString = "Server=myServerAddress;Database=myDataBase;User Id=myUsername;Password=myPassword;"
    $conn.Open() > $null
    
    echo "Connected to $DEFAULT_DB_SERVER"

    $conn.Close()
    $conn.Dispose()
}
catch {

    echo "Could not conect to database server: $DEFAULT_DB_SERVER"
    exit -1
}

echo "Extracting data creation scripts..."
unzip $__dataInstallationZipFile $__sourceCodeRootFolder $true
echo "Source extracted to $__sourceCodeRootFolder"

if(!(Test-Path $__sourceCodeRootFolder))
{
    Throw "Data creation scripts not extracted"
}

cd $__sourceCodeRootFolder\edu.harvard.i2b2.data\Release_1-7\NewInstall

installCrc
installHive
installIM
installOnt
installPM
installWork

cd $__currentDirectory

echo "i2b2 Data Installation Completed"
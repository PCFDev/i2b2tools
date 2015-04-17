
require $env:JAVA_HOME "JAVA_HOME must be set"
require $env:ANT_HOME "ANT_HOME must be set"
require $env:JBOSS_HOME "JBOSS_HOME must be set"
require $JBOSS_ADDRESS "JBOSS_ADDRESS must be set"
require $JBOSS_PORT "JBOSS_PORT must be set"
require $JBOSS_ADMIN "JBOSS_ADMIN must be set"
require $JBOSS_PASS "JBOSS_PASS must be set"

#Install chocolatey https://chocolatey.org/
#iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

function installJava{
    if((isJavaInstalled) -eq $false){
        $client = new-object System.Net.WebClient 
        $cookie = "oraclelicense=accept-securebackup-cookie"
        $client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie) 

        echo "Downloading Java JDK"
    
        #$client.downloadFile($__javaDownloadUrl, $__tempFolder + "\jdk.exe")
        #HACK --- only for testing... uncomment the line above
        cp _downloads/jdk.exe $__tempFolder

        echo "Java Downloaded"

        echo "Installing Java to $env:JAVA_HOME"

        $__javaInstallerPath = $__tempFolder + "\jdk.exe"

        exec $__javaInstallerPath '/s INSTALLDIR=c:\opt\java /L C:\opt\java-install.log'    

        addToPath "$env:JAVA_HOME\bin;"
    }
    echo "Java Installed"
}

function installAnt {
    if((isAntInstalled) -eq $false){

        echo "Downloading ant"
  
        #wget $__antDownloadUrl -OutFile $__tempFolder"\ant.zip"
        #HACK --- only for testing... uncomment the line above

        cp _downloads/ant.zip $__tempFolder
  
        echo "Ant Downloaded"

        echo "Installing Ant"
 
        unzip $__tempFolder"\ant.zip" $env:ANT_HOME"\..\"

        mv $env:ANT_HOME"\..\"$__antFolderName $env:ANT_HOME   

        addToPath "$env:ANT_HOME\bin;"
    }
    echo "Ant Installed"
}

function installJBoss{
    if((test-path $env:JBOSS_HOME) -eq $false){

        echo "Installing JBOSS"

        #wget $__jbossDownloadUrl -OutFile $__tempFolder\jboss.zip
        #HACK --- only for testing... uncomment the line above
        cp _downloads/jboss.zip $__tempFolder

        unzip $__tempFolder\jboss.zip $env:JBOSS_HOME\..\

        mv $env:JBOSS_HOME\..\$__jbossFolderName $env:JBOSS_HOME

        mv $env:JBOSS_HOME\standalone\configuration\standalone.xml $env:JBOSS_HOME\standalone\configuration\standalone.xml.bak

        interpolate_file skel\jboss\standalone.xml "JBOSS_ADDRESS" $JBOSS_ADDRESS |
            interpolate "JBOSS_PORT" $JBOSS_PORT | 
            Out-File -Encoding utf8 $env:JBOSS_HOME\standalone\configuration\standalone.xml

           #> $env:JBOSS_HOME\standalone\configuration\standalone.xml
           
        #&$env:JBOSS_HOME\bin\add-user.bat $JBOSS_ADMIN $JBOSS_PASS

    
        addToPath "$env:JBOSS_HOME\bin;"

    }
    echo "JBOSS Installed"
}

function installJBossService{
    $jbossSvc = Get-Service jboss*
    if($jbossSvc -eq $null){
        echo "Installing JBOSS Service"
        echo "Downloading $__jbossServiceDownloadUrl"
    
        #wget $__jbossServiceDownloadUrl -OutFile $__tempFolder\jboss-svc.zip
        #HACK --- only for testing... uncomment the line above
        cp _downloads/jboss-svc.zip $__tempFolder

        echo "JBOSS Service downloaded"

        unzip $__tempFolder\jboss-svc.zip $env:JBOSS_HOME

        echo "installing JBOSS service"
        cp skel\jboss\service.bat $env:JBOSS_HOME\bin\service.bat -force
    
        &$env:JBOSS_HOME\bin\service.bat install

        #echo "setting JBOSS service to Automatic and starting..."
        Set-Service jboss -StartupType Automatic
        #Start-Service jboss

        echo "Adding management user to JBOSS"

        #cmd /c $env:JBOSS_HOME\bin\add-user.bat $JBOSS_ADMIN $JBOSS_PASS
        #jbossAdmin=a5fd931cf31f9ed58863cfbab5dc3262
        #echo HASHING: ($JBOSS_ADMIN + ":ManagementRealm:" + $JBOSS_PASS)

        $hashPass = hash ($JBOSS_ADMIN + ":ManagementRealm:" + $JBOSS_PASS)

        $jbossUser = "$JBOSS_ADMIN=$hashPass" 

        echo $jbossUser

        echo ([Environment]::NewLine)$jbossUser |
            Out-File  $env:JBOSS_HOME\standalone\configuration\mgmt-users.properties -Append -Encoding utf8

        #>> $env:JBOSS_HOME\standalone\configuration\mgmt-users.properties
    }
    echo "JBOSS service installed"
}

function installAxis{
    if(!(Test-Path "$env:JBOSS_HOME\standalone\deployments\i2b2.war"))
    {

        echo "Installing AXIS War"

        #wget "http://mirror.symnds.com/software/Apache/axis/axis2/java/core/1.6.2/axis2-1.6.2-war.zip" -OutFile $__tempFolder\axis2-1.6.2-war.zip

        cp _downloads\axis2-1.6.2-war.zip $__tempFolder\axis2-1.6.2-war.zip -force

        unzip $__tempFolder\axis2-1.6.2-war.zip $__tempFolder\axis2-1.6.2-war $true
  
        unzip $__tempFolder\axis2-1.6.2-war\axis2.war $__tempFolder\i2b2.war $true

        mv -Force $__tempFolder\i2b2.war\ $env:JBOSS_HOME\standalone\deployments\

        echo "" > $env:JBOSS_HOME\standalone\deployments\i2b2.war.dodeploy
   

    }

    echo "AXIS War Installed"
}

function installIIS {
    $iis =  Get-WindowsOptionalFeature -FeatureName IIS-WebServerRole -Online

    if($iis.State -ne "Enabled"){
        echo "Installing IIS"
    
        Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -NoRestart
    }
    echo "IIS Installed"
}

function installPHP{

    if((Test-Path $__phpInstallDirectory) -eq $false){
        echo "Installing PHP"

        #Reference: http://php.net/manual/en/install.windows.manual.php
        #wget $__phpDownloadUrl -OutFile $__tempFolder/php.zip
        cp .\_downloads\php.zip $__tempFolder\php.zip

        unzip $__tempFolder/php.zip $__phpInstallDirectory
        cp $__skelDirectory\php\php.ini $__phpInstallDirectory\php.ini
     
        #wget $__vcRedistDownloadUrl -OutFile $__tempFolder/vcredist_x86.exe    
        cp .\_downloads\vcredist_x86.exe $__tempFolder\vcredist_x86.exe

        #Start-process -FilePath ".\$__tempFolder\vcredist_x64.exe" -ArgumentList "/install /quiet" -Verb RunAs
        exec $__tempFolder\vcredist_x86.exe '/install /quiet'

        #Reference: http://php.net/manual/en/install.windows.iis7.php
        $cgi =  Get-WindowsOptionalFeature -FeatureName IIS-CGI -Online

        if($cgi.State -ne "Enabled"){
            Enable-WindowsOptionalFeature -FeatureName IIS-CGI -Online -NoRestart
        }

        #Creating IIS FastCGI process pool
        & $env:WinDir\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='c:\php\php-cgi.exe']" /commit:apphost
       
        #Careating handler mapping for PHP requests      
        & $env:WinDir\system32\inetsrv\appcmd.exe set config  -section:system.webServer/handlers /+"[name='PHP-FastCGI',path='*.php',verb='GET,HEAD,POST',modules='FastCgiModule',scriptProcessor='c:\php\php-cgi.exe',resourceType='Either']"
        #appcmd.exe set config  -section:system.webServer/handlers /+"[name='PHP-FastCGI',path='*.php',verb='GET,HEAD,POST',modules='FastCgiModule',scriptProcessor='c:\php\php-cgi.exe',resourceType='Either']"

        addToPath c:\php

        #echo "<?php PHPINFO() ?>" | sc C:\inetpub\wwwroot\test.php
    }
    echo "PHP Installed"
}

installJava
installAnt
installJBoss
installJBossService
installAxis
installIIS
installPHP
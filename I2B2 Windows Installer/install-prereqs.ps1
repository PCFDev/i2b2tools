#Add-Type -AssemblyName System.IO.Compression.FileSystem

$OutputEncoding=[System.Text.UTF8Encoding]::UTF8

require $env:JAVA_HOME "JAVA_HOME must be set"
require $env:ANT_HOME "ANT_HOME must be set"
require $env:JBOSS_HOME "JBOSS_HOME must be set"

#Install chocolatey https://chocolatey.org/
#iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

$JBOSS_ADDRESS = "0.0.0.0"
$JBOSS_PORT = "9090"
$JBOSS_ADMIN = "jbossAdmin"
$JBOSS_PASS = "jbossP@ss"

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
}
echo "Java Installed"
addToPath "$env:JAVA_HOME\bin;"

if((isAntInstalled) -eq $false){

    echo "Downloading ant"
  
    #wget $__antDownloadUrl -OutFile $__tempFolder"\ant.zip"
    #HACK --- only for testing... uncomment the line above

    cp _downloads/ant.zip $__tempFolder
  
    echo "Ant Downloaded"

    echo "Installing Ant"
 
    unzip $__tempFolder"\ant.zip" $env:ANT_HOME"\..\"

    mv $env:ANT_HOME"\..\"$__antFolderName $env:ANT_HOME   
}
echo "Ant Installed"
addToPath "$env:ANT_HOME\bin;"


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


}
echo "JBOSS Installed"
addToPath "$env:JBOSS_HOME\bin;"


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

function installIIS {
    echo "Installing IIS"
    $iis =  Get-WindowsOptionalFeature -FeatureName IIS-WebServerRole -Online

    if($iis.State -ne "Enabled"){
        Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -NoRestart
    }
    echo "IIS Installed"
}

function installPHP{
    echo "Installing PHP"
    $__phpDownloadUrl = "http://windows.php.net/downloads/releases/php-5.5.24-nts-Win32-VC11-x86.zip"
    $__phpInstallDirectory = "C:\php"

    #Reference: http://php.net/manual/en/install.windows.manual.php
    #wget $__phpDownloadUrl -OutFile $__tempFolder/php.zip
    cp .\_downloads\php.zip $__tempFolder\php.zip

    unzip $__tempFolder/php.zip $__phpInstallDirectory

    cp $__phpInstallDirectory\php.ini-production $__phpInstallDirectory\php.ini


    #Reference: http://php.net/manual/en/install.windows.iis7.php
    $cgi =  Get-WindowsOptionalFeature -FeatureName IIS-CGI -Online

    if($cgi.State -ne "Enabled"){
        Enable-WindowsOptionalFeature -FeatureName IIS-CGI -Online -NoRestart
    }

    #Creating IIS FastCGI process pool
    #exec c:\windows\system32\inetsrv\appcmd.exe "set config /section:system.webServer/fastCGI/+[fullPath='$__phpInstallDirectory\php-cgi.exe']"

    #Creating handler mapping for PHP requests
    #exec c:\windows\system32\inetsrv\appcmd.exe "set config /section:system.webServer/handlers/+[name='PHP_via_FastCGI', path='*.php',verb='*',modules='FastCgiModule',scriptProcessor='$__phpInstallDirectory\php-cgi.exe',resourceType='Either']"

    c:\windows\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='c:\php\php-cgi.exe']" /commit:apphost

    #c:\windows\system32\inetsrv\appcmd.exe set config "Default Web Site" -section:system.webServer/handlers /+"[name='PHP-FastCGI',path='*.php',verb='GET,HEAD,POST',modules='FastCgiModule',scriptProcessor='c:\php\php-cgi.exe',resourceType='Either']"
    c:\windows\system32\inetsrv\appcmd.exe set config  -section:system.webServer/handlers /+"[name='PHP-FastCGI',path='*.php',verb='GET,HEAD,POST',modules='FastCgiModule',scriptProcessor='c:\php\php-cgi.exe',resourceType='Either']"

    echo "<?php PHPINFO() ?>" | sc C:\inetpub\wwwroot\index.php

    echo "PHP Installed"
}

#installIIS
#installPHP
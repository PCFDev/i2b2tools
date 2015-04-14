#Add-Type -AssemblyName System.IO.Compression.FileSystem

require $env:JAVA_HOME "JAVA_HOME must be set"
require $env:ANT_HOME "ANT_HOME must be set"
require $env:JBOSS_HOME "JBOSS_HOME must be set"


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

}
echo "JBOSS Installed"
addToPath "$env:JBOSS_HOME\bin;"


$jbossSvc = Get-Service jboss*
if($jbossSvc -eq $null){
    echo "Installing JBOSS Service"
    echo "Downloading $__jbossServiceDownloadUrl"
    
    wget $__jbossServiceDownloadUrl -OutFile $__tempFolder\jboss-svc.zip
    #HACK --- only for testing... uncomment the line above
    cp _downloads/jboss-svc.zip $__tempFolder

    unzip $__tempFolder\jboss-svc.zip $env:JBOSS_HOME

    cp skel\jboss_service.bat $env:JBOSS_HOME\bin\service.bat -force

    &$env:JBOSS_HOME\bin\service.bat install

    #replace run.bat with standalone.bat
    #replace (call shutdown -S) with (call jboss-cli.bat --connect --command=:shutdown)

    #Set to auto start...

}
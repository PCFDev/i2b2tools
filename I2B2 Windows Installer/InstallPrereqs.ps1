Add-Type -AssemblyName System.IO.Compression.FileSystem



if((isJavaInstalled) -eq $false){
    $client = new-object System.Net.WebClient 
    $cookie = "oraclelicense=accept-securebackup-cookie"
    $client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie) 

    echo "Downloading Java JDK"
    
    #$client.downloadFile($__javaDownloadUrl, $__tempFolder + "\jdk.exe")
    #HACK --- only for testing... uncomment the line above
    cp jdk.exe $__tempFolder

    echo "Java Downloaded"
    echo ("Installing Java to " + $env:JAVA_HOME)

    #$arguments = @(
	#    '/s', "/v/qn`" INSTALLDIR=\`"$env:JAVA_HOME\`" REBOOT=Supress IEXPLORER=0 MOZILLA=0 /L \`"java-install.log\`"`""
    #)

    #$proc = Start-Process $__tempFolder"\jdk.exe" -ArgumentList $arguments -Wait -PassThru

    $__javaInstallerPath = $__tempFolder + "\jdk.exe"

    $proc = Start-Process -FilePath $__javaInstallerPath -ArgumentList '/s INSTALLDIR=c:\opt\java /L C:\opt\java-install.log'

    if($proc.ExitCode -ne 0) {
	    Throw "ERROR"
    }
    echo "Java Installed"
}

if($env:JAVA_HOME -eq ""){
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $env:JAVA_HOME, 'machine')
    echo "JAVA_HOME environment variable set"
}

if(![System.Environment]::GetEnvironmentVariable("PATH").Contains($env:JAVA_HOME)){

    echo "Adding JAVA bin to PATH"
    appedToPath $env:JAVA_HOME + "\bin;"
}






#If ant is not installed...
if((isAntInstalled) -eq $false){

    echo "Downloading ant"
  
    #Invoke-WebRequest $__antDownloadUrl -OutFile $__tempFolder"\ant.zip"
    #HACK --- only for testing... uncomment the line above
  
    cp ant.zip $__tempFolder
  
    echo "Ant Downloaded"

    echo "Installing Ant"
    
    #if(Test-Path $env:ANT_HOME){
	#    Remove-Item $env:ANT_HOME -recurse
    #}

    ##New-Item $env:ANT_HOME -Type directory -Force
    
    #[System.IO.Compression.ZipFile]::ExtractToDirectory($__tempFolder + "\ant.zip", $env:ANT_HOME + "\..\")
    
    unzip $__tempFolder"\ant.zip" $env:ANT_HOME"\..\"

    mv $env:ANT_HOME"\..\"$__antFolderName $env:ANT_HOME

}

if($env:ANT_HOME -eq ""){
    [System.Environment]::SetEnvironmentVariable('ANT_HOME', $env:ANT_HOME, 'machine')
    echo "ANT_HOME environment variable set"
}


if(![System.Environment]::GetEnvironmentVariable("PATH").Contains($env:ANT_HOME)){

    echo "Adding ANT bin to PATH"
    appedToPath $env:ANT_HOME + "\bin;"
}


<#
.AUTHOR
Josh Hahn
Pediatrics Development Team
Washington University in St. Louis

.DATE
April 14, 2015
#>
<#
.SYNOPSIS
Install tomcat 8 on Windows Server


.DESCRIPTION
This script will download the correctversion of Apache Tomcat 8.0. It will then unzip to 
another directory and copy the contents into the shrine\tomcat directory beneath the 
user-specified or default directory. It will also install Tomcat 8.0 as a service running 
automatically.

.PARAMETER $tomcat_path
Define a path for tomcat to be extracted to. Avoid directory locations that include spaces
within their paths.

.PARAMETER $InstallService
Tomcat is installed as a Windows service by default. Using the -s alias and $false will 
keep Tomcat from being installed as a service.

.EXAMPLE
.\tomcat_install -s $false
Skips the installation of Tomcat as a Windows service.

.EXAMPLE
.\tomcat_install C:\newDirectory
tomcat_install will extract Tomcat to the C:\newDirectory\shrine\tomcat directory and
install Tomcat as a service.

.EXAMPLE
.\tomcat_install C:\otherDirectory -s $false
tomcat_install will extract Tomcat to the C:\otherDirectory\shrine\tomcat directory and
does not install Tomcat as a service.

.EXAMPLE
PowerShell will number them for you when it displays your help text to a user.
#>


[CmdletBinding()]
Param(
    [parameter(Mandatory=$false)]
	[AllowEmptyString()]
	[string]$tomcat_path,

    [parameter(Mandatory=$false)]
	[alias("s")]
	[bool]$InstallService=$true
)

#Include functions.ps1 for unzip functionality
#Include configurations.ps1 for file download url
. .\functions.ps1
. .\configuration.ps1


#If given no argument for install directory, set default directory C:\opt
if($tomcat_path -eq "")
{
    echo "default path set to C:\opt"
    $tomcat_path="C:\opt"
}

#Using a process level Environment Variable simplifies the multiple calls
#to the install directory
$Env:TOMCAT = $tomcat_path

#Create temp downloads folder
if(!(Test-Path $Env:TOMCAT\shrine\downloads)){
    echo "creating temporary download location..."
    mkdir $Env:TOMCAT\shrine\downloads
}

#Download tomcat archive, unzip to temp directory, copy contents to shrine\tomcat folder
#and remove the downloads and temp folders
if(Test-Path $Env:TOMCAT\shrine\downloads\tomcat.zip){
    Remove-Item $Env:TOMCAT\shrine\downloads\tomcat.zip
}
echo "downloading tomcat archive..."
Invoke-WebRequest $__tomcatDownloadUrl -OutFile $Env:TOMCAT\shrine\downloads\tomcat8.zip
unzip $Env:TOMCAT\shrine\downloads\tomcat8.zip $Env:TOMCAT\shrine
if(Test-Path $Env:TOMCAT\shrine\tomcat){
    Remove-Item $Env:TOMCAT\shrine\tomcat -Recurse
}
mkdir $Env:TOMCAT\shrine\tomcat

Copy-Item $Env:TOMCAT\shrine\apache-tomcat-8.0.21\* -Destination $Env:TOMCAT\shrine\tomcat -Container -Recurse
echo "cleaning up..."
Remove-Item $Env:TOMCAT\shrine\downloads -Recurse
Remove-Item $Env:TOMCAT\shrine\apache-tomcat-8.0.21 -Recurse

#This environment variable is required for Tomcat to run and to install as a service
setEnvironmentVariable("CATALINA_HOME", "$Env:TOMCAT\shrine\tomcat")

#If $InstallService is $true (as default), this will install the Tomcat Windows Service.
#It will set the service to Automatic startup, rename it to Apache Tomcat 8.0 and start it.
if($InstallService -eq $true)
{
    $Env:JAVA_HOME = "C:\Program Files\Java\jdk1.7.0_75"
    #JAVA_HOME Set in configuration.ps1, Uncomment if configuration.ps1 is incorrect

    echo "installing Tomcat8 service..."
    & "$Env:CATALINA_HOME\bin\service.bat" install
    
    & $Env:CATALINA_HOME\bin\tomcat8 //US//Tomcat8 --DisplayName="Apache Tomcat 8.0"

    echo "setting Tomcat8 service to Automatic and starting..."
    Set-Service Tomcat8 -StartupType Automatic
    Start-Service Tomcat8   
}


.\shrine_install.ps1
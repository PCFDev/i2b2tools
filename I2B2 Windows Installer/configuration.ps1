echo "Loading system configuration"

##############################
#DO NOT EDIT: SYSTEM VARIABLES
##############################
$OutputEncoding=[System.Text.UTF8Encoding]::UTF8

$__rootFolder = "c:\opt"

$__currentDirectory = (Get-Item -Path ".\" -Verbose).FullName
$__skelDirectory = $__currentDirectory + "\skel"
$__tempFolder = $__currentDirectory + "\.temp"

$__sourceCodeZipFile = $__skelDirectory + "\i2b2\i2b2core-src-1704.zip"
$__dataInstallationZipFile = $__skelDirectory + "\i2b2\i2b2createdb-1704.zip"

$__sourceCodeRootFolder = $__rootFolder + "\i2b2"

$__webclientZipFile = $__skelDirectory + "\i2b2\i2b2webclient-1704.zip"
$__webclientInstallFolder = "c:\inetpub\wwwroot"

$__jbossFolderName = "jboss-as-7.1.1.Final"
$__jbossDownloadUrl = "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip"
$__jbossServiceDownloadUrl = "http://downloads.jboss.org/jbossnative/2.0.10.GA/"

if([Environment]::Is64BitOperatingSystem -eq $true){
    $__jbossServiceDownloadUrl = $__jbossServiceDownloadUrl + "jboss-native-2.0.10-windows-x64-ssl.zip"
} else {
    $__jbossServiceDownloadUrl = $__jbossServiceDownloadUrl + "jboss-native-2.0.10-windows-x86-ssl.zip"
}


$__antFolderName = "apache-ant-1.9.4"
$__antDownloadUrl = "http://mirror.tcpdiag.net/apache/ant/binaries/" + $__antFolderName + "-bin.zip"

$__javaDownloadUrl = ""

if([Environment]::Is64BitOperatingSystem -eq $true){
	$__javaDownloadUrl = "http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-windows-x64.exe"
} else {
    #NOTE: test this url, if it works we can break out the filename and folder..?
	$__javaDownloadUrl = "https://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-windows-i586.exe"
}

$__axisDownloadUrl = "http://mirror.symnds.com/software/Apache/axis/axis2/java/core/1.6.2/axis2-1.6.2-war.zip"


$__phpDownloadUrl = "http://windows.php.net/downloads/releases/php-5.5.24-nts-Win32-VC11-x86.zip"
$__phpInstallDirectory = "C:\php"
$__vcRedistDownloadUrl = "http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"


if([Environment]::Is64BitOperatingSystem -eq "True")
    {
        $__tomcatDownloadUrl = "http://ftp.wayne.edu/apache/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21-windows-x64.zip"
    }
    else
    {
        $__tomcatDownloadUrl = "http://ftp.wayne.edu/apache/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21-windows-x86.zip"
    }
    
    


export JAVA_HOME="c:\opt\java"
export ANT_HOME="c:\opt\ant"
export JBOSS_HOME="c:\opt\jboss"
export NOPAUSE=1

##############################
#END SYSTEM VARIABLES
##############################

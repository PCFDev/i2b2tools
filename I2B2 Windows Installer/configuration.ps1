Write-Host loading configuration

$__windows_arch = "x64"

##############################
#DO NOT EDIT: SYSTEM VARIABLES
##############################

$__currentDirectory = (Get-Item -Path ".\" -Verbose).FullName
$__tempFolder = $__currentDirectory + "\.temp"
$__sourceCodeZipFile = $__currentDirectory + "\i2b2core-src-1704.zip"
$__sourceCodeRootFolder = $__tempFolder + "\i2b2core-src"


$__jbossDownloadUrl = "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip"

$__jbossServiceDownloadUrl = "http://www.jboss.org/jbossweb/downloads/jboss-native-2-0-10/"

if($windows_arch -eq "x64"){
    $__jbossServiceDownloadUrl = $__jbossServiceDownloadUrl + "jboss-native-2.0.10-windows-x64-ssl.zip"
} else {
    $__jbossServiceDownloadUrl = $__jbossServiceDownloadUrl + "jboss-native-2.0.10-windows-x86-ssl.zip"
}


$__antFolderName = "apache-ant-1.9.4"
$__antDownloadUrl = "http://mirror.tcpdiag.net/apache/ant/binaries/" + $__antFolderName + "-bin.zip"

$__javaDownloadUrl = ""

if($windows_arch -eq "x64"){
	$__javaDownloadUrl = "http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-windows-x64.exe"
} else {
    #NOTE: test this url, if it works we can break out the filename and folder..?
	$__javaDownloadUrl = "https://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-windows-i586.exe"
}

$__axisDownloadUrl = "https://www.i2b2.org/software/projects/installer/axis2-1.6.2-war.zip"


if([Environment]::Is64BitOperatingSystem -eq "True")
    {
        $__tomcatDownloadUrl = "http://ftp.wayne.edu/apache/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21-windows-x64.zip"
    }
    else
    {
        $__tomcatDownloadUrl = "http://ftp.wayne.edu/apache/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21-windows-x86.zip"
    }
    
    

$env:JAVA_HOME="c:\opt\java"
$env:ANT_HOME="c:\opt\ant"
$env:JBOSS_HOME="c:\opt\jboss"
##############################
#END SYSTEM VARIABLES
##############################

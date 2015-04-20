
<#
.SYNOPSIS
Install i2b2 on a windows server


.DESCRIPTION
The description is usually a longer, more detailed explanation of what the script or function does. Take as many lines as you need.

.PARAMETER InstallPrereqs
Install the required software Java, Ant and JBoss (including JBoss as a service) as discussed in the i2b2 Server Requirements section of the installation guide.

.PARAMETER InstallDatabases
Run the ant scripts from the Data Installation Section of the Installation Guide (requires the createdb i2b2 package)

.EXAMPLE
.\Install-I2B2
Runs the installation of the i2b2 Server Requirements and skips the Data Installation process

.EXAMPLE
.\Install-I2B2 -d $false
Runs the installation of the i2b2 Server Requirements and skips the Data Installation process


.EXAMPLE
.\Install-I2B2 -p $false
Skips the installation of the i2b2 Server Requirements and the Data Installation process


.EXAMPLE
.\Install-I2B2 -p $false -d $false
Skips the installation of the i2b2 Server Requirements and the Data Installation process

#>


[CmdletBinding()]
Param(
    [parameter(Mandatory=$false)]
	[alias("p")]
	[bool]$InstallPrereqs=$true,

    [parameter(Mandatory=$false)]
	[alias("d")]
	[bool]$InstallDatabases=$false,

    [parameter(Mandatory=$false)]
	[alias("data")]
	[bool]$InstallDemoData=$false,

    [parameter(Mandatory=$false)]
	[alias("c")]
	[bool]$InstallCells=$true,

    [parameter(Mandatory=$false)]
	[alias("w")]
	[bool]$InstallWebClient=$true
)

$OutputEncoding=[System.Text.UTF8Encoding]::UTF8

$__timer = [Diagnostics.Stopwatch]::StartNew()

. .\functions.ps1
. .\configuration.ps1
#. .\common.ps1
. .\config-i2b2.ps1

 if(Test-Path $__rootFolder){

 #Todo ... this is not proper

} else {
 
    New-Item $__rootFolder -Type directory -Force > $null

    echo "Created " $__rootFolder
}
  

#Create a directory to work out of
createTempFolder

if($InstallPrereqs -eq $true){
    . .\install-prereqs.ps1
}


if($InstallDatabases -eq $true){
    . .\install-data.ps1
}


if($InstallCells -eq $true){
    . .\install-i2b2.ps1 
}


#clean up after ourself
#removeTempFolder

net start jboss

formatElapsedTime $__timer.Elapsed
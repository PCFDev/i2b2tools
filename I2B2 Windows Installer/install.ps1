
<#
.SYNOPSIS
Install i2b2 on a windows server


.DESCRIPTION
The description is usually a longer, more detailed explanation of what the script or function does. Take as many lines as you need.

.PARAMETER InstallPrereqs
Install Java, Ant and JBoss (including JBoss as a service)

.PARAMETER filePath
Provide a PARAMETER section for each parameter that your script or function accepts.

.EXAMPLE
.\Install-I2B2 -p $false
Skips the installation of the prereq software


.EXAMPLE
PowerShell will number them for you when it displays your help text to a user.
#>


[CmdletBinding()]
Param(
    [parameter(Mandatory=$false)]
	[alias("p")]
	[bool]$InstallPrereqs=$true,
    [parameter(Mandatory=$false)]
	[alias("d")]
	[bool]$InstallDatabases=$false
)


. .\functions.ps1
. .\configuration.ps1
. .\config-i2b2.ps1




 if(Test-Path $__rootFolder){

 #Todo ... this is not proper

} else {
 
    New-Item $__rootFolder -Type directory -Force > $null

    write-host "Created " $__rootFolder
}
  

#Create a directory to work out of
createTempFolder

if($InstallPrereqs -eq $true){
    . .\install-prereqs.ps1
}


if($InstallDatabases -eq $true){
    . .\install-data.ps1
}


#. .\install-i2b2.ps1 


#clean up after ourself
#removeTempFolder
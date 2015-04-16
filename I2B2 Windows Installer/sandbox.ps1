. .\functions.ps1
. .\configuration.ps1


echo "Is Java Installed: "

if((isJavaInstalled) -eq $false){
    echo "no"
} 
if((isJavaInstalled) -eq $true){
    echo "yes"
}



echo "Is Ant Installed: "

if((isAntInstalled) -eq $false){
    echo "no"
}

if((isAntInstalled) -eq $true){
    echo "yes"
}


#Write-Host $testValue


#export __this2=foo2
#echo $env:__this2

#ls variable:__*

$__this2 = "IAN"
$thirdValue = 3
$now = Get-Date

#interpolate_file test_template.txt "THIS_NAME" $__this2 | 
#    interpolate "THAT_NAME" "Josh" |
#    interpolate "NOW" $now |
#    interpolate "THIRD_VALUE" $thirdValue > server.xml


#Start-Process -FilePath "c:\temp\jre-7u17-windows-i586.exe" -ArgumentList '/S /L c:\temp\javainst.log REBOOT=ReallySuppress JAVAUPDATE=0 WEBSTARTICON=0 SYSTRAY=0'
#Start-Process -FilePath "jdk.exe" -ArgumentList '/S /L c:\temp\javainst.log REBOOT=ReallySuppress JAVAUPDATE=0 WEBSTARTICON=0 SYSTRAY=0'
#Start-Process -FilePath "jdk.exe" -ArgumentList '/quiet /L c:\temp\javainst.log INSTALLDIR=c:\opt\java REBOOT=ReallySuppress JAVAUPDATE=0 WEBSTARTICON=0 SYSTRAY=0'
#Start-Process -FilePath "jdk.exe" -ArgumentList '/quiet /log c:\opt\javainst.log /norestart INSTALLDIR=c:\opt\java'


#Start-Process -FilePath "jdk.exe" -ArgumentList '/log c:\opt\javainst.log /norestart INSTALLDIR=c:\opt\java'
#Start-Process -FilePath "jdk.exe" -ArgumentList '/uninstall'

$env:XZY = "bob"

require $env:XZY "XYZ must be set"

printEnvValues

function printEnvValues {

  #Refresh env
    foreach($level in "Machine","User") {
    
        [Environment]::GetEnvironmentVariables($level).GetEnumerator() | % { echo ($_.Name + "=" + $_.Value)}


    }

}



$someString = "bob2:ManagementRealm:test"
$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = new-object -TypeName System.Text.UTF8Encoding
$hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($someString))).ToLower().Replace('-', '')
echo $hash
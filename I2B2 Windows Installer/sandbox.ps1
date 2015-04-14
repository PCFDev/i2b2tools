. .\configuration.ps1
. .\functions.ps1

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

$thirdValue = 3
$now = Get-Date

interpolate_file test_template.txt "THIS_NAME" $env:__this2 | 
    interpolate "THAT_NAME" "that" |
    interpolate "NOW" $now |
    interpolate "THIRD_VALUE" $thirdValue > out.txt


#Start-Process -FilePath "c:\temp\jre-7u17-windows-i586.exe" -ArgumentList '/S /L c:\temp\javainst.log REBOOT=ReallySuppress JAVAUPDATE=0 WEBSTARTICON=0 SYSTRAY=0'
#Start-Process -FilePath "jdk.exe" -ArgumentList '/S /L c:\temp\javainst.log REBOOT=ReallySuppress JAVAUPDATE=0 WEBSTARTICON=0 SYSTRAY=0'
#Start-Process -FilePath "jdk.exe" -ArgumentList '/quiet /L c:\temp\javainst.log INSTALLDIR=c:\opt\java REBOOT=ReallySuppress JAVAUPDATE=0 WEBSTARTICON=0 SYSTRAY=0'
#Start-Process -FilePath "jdk.exe" -ArgumentList '/quiet /log c:\opt\javainst.log /norestart INSTALLDIR=c:\opt\java'

Start-Process -FilePath "jdk.exe" -ArgumentList '/log c:\opt\javainst.log /norestart INSTALLDIR=c:\opt\java'

Start-Process -FilePath "jdk.exe" -ArgumentList '/uninstall'

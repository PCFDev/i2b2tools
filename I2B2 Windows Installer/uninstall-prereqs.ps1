$java = Get-WmiObject -Class win32_product | where { $_.Name -like "*Java*"}

if ($java -ne $null)
{
    foreach ($app in $java)
    {
    
        write-host "Removing " $app.Name "..."
        #write-host $app.LocalPackage
        #write-host $app.IdentifyingNumber
   
        &cmd /c "msiexec /uninstall $($app.IdentifyingNumber) /quiet"
    }
}
else { Write-Host "java not installed..." }


if(Test-Path "c:\opt\ant"){
    write-host "Removing Ant..."
	Remove-Item  "c:\opt\ant" -recurse -force
}  

if(Test-Path "c:\opt\jboss"){
    write-host "Removing JBOSS..."
	Remove-Item  "c:\opt\jboss" -recurse -force
}  

 &$env:JBOSS_HOME\bin\service.bat stop
 &$env:JBOSS_HOME\bin\service.bat uninstall

Remove-Item C:\opt\jboss\licenses -force
Remove-Item C:\opt\jboss\bin\native -force
Remove-Item C:\opt\jboss\bin\*.exe -force
Remove-Item C:\opt\jboss\bin\service.bat -force
Remove-Item C:\opt\jboss\bin\README-service.txt -force


echo "Cleaning up path"
$cleanPath = $env:Path.Replace("$env:JAVA_HOME\bin", "")
$cleanPath = $cleanPath.Replace("$env:ANT_HOME\bin", "")
$cleanPath = $cleanPath.Replace("$env:JBOSS_HOME\bin", "")
$cleanPath = $cleanPath.TrimEnd(';')
$env:Path = $cleanPath

[Environment]::SetEnvironmentVariable("PATH", $cleanPath, "Machine")

echo "Removing Environment Variables"

[Environment]::SetEnvironmentVariable("ANT_HOME",$null,"Machine")
[Environment]::SetEnvironmentVariable("JAVA_HOME",$null,"Machine")
[Environment]::SetEnvironmentVariable("JBOSS_HOME",$null,"Machine")




Write-Host "done."
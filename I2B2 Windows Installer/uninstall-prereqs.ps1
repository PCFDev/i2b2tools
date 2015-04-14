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
	Remove-Item  "c:\opt\ant" -recurse
}  

write-host "Removing Environment Variables"

[Environment]::SetEnvironmentVariable("ANT_HOME",$null,"Machine")
[Environment]::SetEnvironmentVariable("JAVA_HOME",$null,"Machine")
[Environment]::SetEnvironmentVariable("JBOSS_HOME",$null,"Machine")

Write-Host "done."
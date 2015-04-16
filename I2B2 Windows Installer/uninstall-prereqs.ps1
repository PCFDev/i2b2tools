. .\functions.ps1
. .\configuration.ps1

function removeFromPath($path) {

    $cleanPath = $env:Path.Replace($path, "")
    $cleanPath = $cleanPath.TrimEnd(';') 
    $env:Path = $cleanPath
    [Environment]::SetEnvironmentVariable("PATH", $cleanPath, "Machine")
}

function removeJBOSS {

    if(Test-Path "c:\opt\jboss"){

           
        Stop-Service jboss
        #&$env:JBOSS_HOME\bin\service.bat stop
        &$env:JBOSS_HOME\bin\service.bat uninstall

        Remove-Item C:\opt\jboss\licenses -recurse -force
        Remove-Item C:\opt\jboss\bin\native -recurse -force
        Remove-Item C:\opt\jboss\bin\*.exe -force
        Remove-Item C:\opt\jboss\bin\service.bat -force
        Remove-Item C:\opt\jboss\bin\README-service.txt -force

        write-host "Removing JBOSS..."
	    Remove-Item  "c:\opt\jboss" -recurse -force
        removeFromPath "$env:JBOSS_HOME\bin"    
        [Environment]::SetEnvironmentVariable("JBOSS_HOME",$null,"Machine")
    } 

  
}

function removeJava {

    $java = Get-WmiObject -Class win32_product | where { $_.Name -like "*Java*"}

    if ($java -ne $null)
    {        
        foreach ($app in $java)
        {
    
            write-host "Removing " $app.Name "..."
            #write-host $app.LocalPackage
            #write-host $app.IdentifyingNumber
   
            &cmd /c "msiexec /uninstall $($app.IdentifyingNumber) /quiet /norestart"
        }

        removeFromPath "$env:JAVA_HOME\bin"
        [Environment]::SetEnvironmentVariable("JAVA_HOME",$null,"Machine")

    }
    else { Write-Host "java not installed..." }
}

function removeAnt {

    if(Test-Path "c:\opt\ant"){
        write-host "Removing Ant..."
	    Remove-Item  "c:\opt\ant" -recurse -force
        removeFromPath "$env:ANT_HOME\bin"
        [Environment]::SetEnvironmentVariable("ANT_HOME",$null,"Machine")
    }    
}
 


 #removeAnt
 removeJBOSS
 #removeJava




Write-Host "done."
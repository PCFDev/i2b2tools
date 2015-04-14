Add-Type -AssemblyName System.IO.Compression.FileSystem

echo "importing functions"


function setEnvironmentVariable($name, $value){
    [System.Environment]::SetEnvironmentVariable($name, $value, 'machine')
    [System.Environment]::SetEnvironmentVariable($name, $value, 'process')
}


function export ([string]$variableAndValue){
<#
    .SYNOPSIS give support for bash style syntax: export VARNAME=VALUE
#>

    $arr = $variableAndValue.Split("=");
    
    $varName = $arr[0]
    $value = $arr[1]

    setEnvironmentVariable $varName $value
   
}

function appendToPath($pathToAppend){

    #verify that the current path ends with ; or append it to the start of the pathToAppend

    if(!$env:PATH.EndsWith(";")){
        $pathToAppend = ";" + $pathToAppend
    }

    echo $pathToAppend

    setEnvironmentVariable "PATH" $env:PATH + $pathToAppend

}


function isAntInstalled {    
    <#    
    .SYNOPSIS Check it see if ant is installed
    #>    
    try{
        
        $out = &"ant" -version 2>&1
        $antver = $out[0].tostring();

        return  ($antver -gt "")

    }catch {
        return $false
    }
}


function isJavaInstalled {    
    <#    
    .SYNOPSIS Check it see if Java is installed
    #>    
  
    try{
        $out = &"java.exe" -version 2>&1
        $javaVer = $out[0].tostring();
        return ($javaVer -gt "")
    } catch {
        return $false
    }
}


function removeTempFolder{
    if(Test-Path $__tempFolder){
	    Remove-Item $__tempFolder -recurse
    }   
}

function createTempFolder{
    
    removeTempFolder

    New-Item $__tempFolder -Type directory -Force
}


function unzip($zipFile, $folderPath, $removeFolder = $false) {

    try {

        if($removeFolder -eq $true){

            if(Test-Path $folderPath){
	            Remove-Item $folderPath -recurse
            }
    
            New-Item $folderPath -Type directory -Force
        }
    }
    catch {
     echo ("Could not remove folder " + $folderPath)
    }

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $folderPath)

}


function appendToPath_old($pathToAppend){

    #verify that the current path ends with ; or append it to the start of the pathToAppend
    if(![System.Environment]::GetEnvironmentVariable("PATH").EndsWith(";")){
        $pathToAppend = ";" + $pathToAppend
    }


    echo $pathToAppend

    setEnvironmentVariable "PATH" $env:PATH + $pathToAppend

    [System.Environment]::SetEnvironmentVariable("PATH", $env:PATH + $pathToAppend, "Machine")


    #Refresh env
    foreach($level in "Machine","User") {

        [Environment]::GetEnvironmentVariables($level).GetEnumerator() | % {
        
            # For Path variables, append the new values, if they're not already in there
            if($_.Name -match 'Path$') { 
                $_.Value = ($((Get-Content "Env:$($_.Name)") + ";$($_.Value)") -split ';' | Select -unique) -join ';'
            }

            $_

        } | Set-Content -Path { "Env:$($_.Name)" }


    }

   echo "Path Set" 
   [System.Environment]::GetEnvironmentVariable("PATH")

}




function interpolate($Pattern, $Replacement){

    begin {}
    process {echo $_.Replace($Pattern, $Replacement) }
    end {}

}


function interpolate_file($InputFile, $Pattern, $Replacement){
   
    $replaced = ""

    Get-Content $InputFile | Foreach-Object {$_.Replace($Pattern,  $Replacement)} | Set-Variable  -Name "replaced"

    echo $replaced

}

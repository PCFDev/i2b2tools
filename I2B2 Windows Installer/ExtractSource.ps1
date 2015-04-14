Add-Type -AssemblyName System.IO.Compression.FileSystem

if(Test-Path $__sourceCodeRootFolder){
	Remove-Item $__sourceCodeRootFolder -recurse
}

New-Item $__sourceCodeRootFolder -Type directory -Force

[System.IO.Compression.ZipFile]::ExtractToDirectory($__sourceCodeZipFile, $__sourceCodeRootFolder)


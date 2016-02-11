<# Copyright (c) Microsoft Open Technologies, Inc.  All Rights Reserved.  Licensed under the Apache License, Version 2.0.  See License.txt in the project root for license information. #>

<# Download and install the dotnet cli #>

param( [string] $outDir )

$cliLatestPackage = "https://dotnetcli.blob.core.windows.net/dotnet/dev/Binaries/Latest/dotnet-win-x64.latest.zip"

#make path absolute
$repoDir = Split-Path -parent (Split-Path -parent $PSCommandPath)
$outDir = [io.path]::combine($repoDir, $outDir)

#cleanup
Write-Host "cleanup '$outDir'"

if (Test-Path $outDir)
{
    rm -Recurse $outDir
}

#download repository

$tempPath = [System.IO.Path]::GetTempFileName()

Write-Host "Temp zip path '$tempPath'"

Invoke-WebRequest -UseBasicParsing $cliLatestPackage -OutFile $tempPath

# extract zip

Write-Host "Extract zip to '$outDir'"

Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($tempPath, $outDir)

# done
Write-Host "Done."

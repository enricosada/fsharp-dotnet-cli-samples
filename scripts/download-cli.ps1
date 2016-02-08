<# Copyright (c) Microsoft Open Technologies, Inc.  All Rights Reserved.  Licensed under the Apache License, Version 2.0.  See License.txt in the project root for license information. #>

<# Download and install the dotnet cli #>

# $cliLatestPackage = "https://dotnetcli.blob.core.windows.net/dotnet/dev/Binaries/Latest/dotnet-win-x64.latest.zip"

# $zip_branch = "https://github.com/dotnet/cli/archive/rel/1.0.0.zip"
# $zip_commit = "https://github.com/dotnet/cli/archive/168bfc677803c70ed477a5c72ca703198c1f8848.zip"

param( [string] $repoZipUrl, [string] $outDir )

$ErrorActionPreference = "Stop"

#make path absolute
$repoDir = Split-Path -parent (Split-Path -parent $PSCommandPath)
$tempRepoDir = [io.path]::combine($repoDir, ".dotnetrepo")
$outDir = [io.path]::combine($repoDir, $outDir)

#cleanup
Write-Host "cleanup '$tempPath'"

if (Test-Path $outDir)
{
	rm -Recurse $tempRepoDir
}

#download repository

$tempPath = [System.IO.Path]::GetTempFileName()

Write-Host "Temp zip path '$tempPath'"

Invoke-WebRequest -UseBasicParsing $repoZipUrl -OutFile $tempPath

# extract zip

Write-Host "Extract zip to '$tempRepoDir'"

md -Force $tempRepoDir

Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($tempPath, $tempRepoDir)

$tempRepoName = Split-Path -leaf (gci -Path $tempRepoDir | Select-Object -First 1)

$unzippedRepoDir = [io.path]::combine($tempRepoDir, $tempRepoName)

# execute build.cmd

$buildCmdPath = [io.path]::combine($unzippedRepoDir, 'build.cmd')
Write-Host "Executing build.cmd in downloaded repo ('$buildCmdPath')..."

cmd /c $buildCmdPath

# copy dotnet cli to $outDir

$dotnetcliArtifacts = [io.path]::combine($unzippedRepoDir, 'artifacts\win7-x64\stage2')
Write-Host "Copying built dotnet cli to '$outDir' from '$dotnetcliArtifacts'"

md -Force $outDir

Copy-Item -Path "$dotnetcliArtifacts\*" -Destination "$outDir" -Recurse

# done
Write-Host "Done."

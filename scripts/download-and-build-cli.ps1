<# Download, build and install the dotnet cli #>

param( [string] $RepoZipUrl, [string] $OutDir )

#download repository

$tempPath = [System.IO.Path]::GetTempFileName()

Write-Host "Temp zip path '$tempPath'"

Invoke-WebRequest -UseBasicParsing $RepoZipUrl -OutFile $tempPath

# extract zip

Write-Host "Extract zip to '$OutDir'"

md -Force $OutDir

Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($tempPath, $OutDir)

$unzippedRepoDir = gci -Path "$OutDir" | % { $_.FullName } | Select-Object -First 1

# execute build.cmd

$buildCmdPath = [io.path]::combine($unzippedRepoDir, 'build.cmd')
Write-Host "Executing build.cmd in downloaded repo ('$buildCmdPath')..."

cmd /c $buildCmdPath

# use dotnet cli
#Write-Host "use alias '$cliAlias'"

#. "$repoDir\scripts\use-dev.ps1" $cliAlias

# done
Write-Host "Done."

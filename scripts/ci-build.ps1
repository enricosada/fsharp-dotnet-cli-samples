
param( [string] $cliAlias, [string] $repoZipUrl, [switch] $latestBinaries )

#make path absolute
$repoDir = Split-Path -parent (Split-Path -parent $PSCommandPath)

# check current dotnet

if (Get-Command dotnet -errorAction SilentlyContinue) {
	Write-Host "current dotnet '$((Get-Command dotnet).Path)'"
}
else {
	Write-Host "dotnet.exe not found"
}

# download and build cli
if ($PSBoundParameters.ContainsKey('repoZipUrl')) 
{
    Write-Host "download and build repo from '$repoZipUrl' as '$cliAlias'"

    invoke-expression -Command "$repoDir\scripts\download-cli.ps1 -repoZipUrl $repoZipUrl -outDir dotnetcli\$cliAlias"
} 
else
{
    if ($PSBoundParameters.ContainsKey('latestBinaries'))
    {
        Write-Host "download latest binaries from '$repoZipUrl' as '$cliAlias'"

        invoke-expression -Command "$repoDir\scripts\download-cli-binaries.ps1 -outDir dotnetcli\$cliAlias"
    }
}

# use dotnet cli
Write-Host "use alias '$cliAlias'"

$useCliAlias = [io.path]::combine($repoDir, 'scripts', 'use-dev.ps1')

. $useCliAlias $cliAlias

if (Get-Command dotnet -errorAction SilentlyContinue) {
	Write-Host "current dotnet '$((Get-Command dotnet).Path)'"
}
else {
	Write-Host "dotnet.exe not found"
}

# run tests

$runTestScript = [io.path]::combine($repoDir, 'scripts', 'run-tests.ps1')
. $runTestScript

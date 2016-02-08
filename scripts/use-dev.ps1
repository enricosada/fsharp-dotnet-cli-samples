
param ([string] $cliAlias)

$cliDir = "$PSScriptRoot\..\dotnetcli\$cliAlias\bin"
if (Test-Path $cliDir) {
    $splat = $env:PATH.Split(";")
    $cliDir = Convert-Path $cliDir
    if ($splat -notcontains $cliDir) {
        $env:PATH="$cliDir;$env:PATH"
    }
} else {
    Write-Host "You don't have a directory '$cliDir'!"
}

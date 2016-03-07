#make path absolute
$rootDir = Split-Path -parent (Split-Path -parent $PSCommandPath)

# restore and compile

Write-Host "Testing HelloConsole..."

Push-Location "$rootDir\HelloConsole"

dotnet restore
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

dotnet --verbose build
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

Pop-Location

# dotnet new

Write-Host "Testing dotnet new..."

Remove-Item "$rootDir\test\test-dotnet-new" -Recurse -ErrorAction Ignore

mkdir "$rootDir\test\test-dotnet-new" -Force | Push-Location

if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

dotnet new --lang f#
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

dotnet restore
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

dotnet --verbose build
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

dotnet --verbose run a b
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

Pop-Location

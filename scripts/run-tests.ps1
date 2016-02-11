#make path absolute
$repoDir = Split-Path -parent (Split-Path -parent $PSCommandPath)

# check dotnet exe

if (Get-Command dotnet -errorAction SilentlyContinue) {
	Write-Host "current dotnet '$((Get-Command dotnet).Path)'"
}
else {
	Write-Host "dotnet.exe not found"
}

# restore and compile

Push-Location "$repoDir\HelloConsole"

dotnet restore
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

dotnet build
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

Pop-Location

# dotnet new

Push-Location "$repoDir\test\test-dotnet-new"
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

dotnet build
if ($LastExitCode -ne 0) {
    throw "Command failed with exit code $LastExitCode."
}

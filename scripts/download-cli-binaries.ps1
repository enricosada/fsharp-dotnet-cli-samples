<# Download and install the dotnet cli #>

param( [string] $OutDir, [string] $Version, [string] $InstallScriptDir )

# download install script from dotnet/cli repo

New-Item -Force -ItemType directory -Path "$InstallScriptDir"

Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/dotnet/cli/rel/1.0.0/scripts/obtain/install.ps1" -OutFile "$InstallScriptDir\install.ps1"

# install a specific dotnet/cli version in DOTNET_INSTALL_DIR directory
$env:DOTNET_INSTALL_DIR = "$OutDir"
& "$InstallScriptDir\install.ps1" -Channel beta -version $Version

# add dotnet to PATH
$env:Path = "$OutDir\cli\bin;$env:Path"

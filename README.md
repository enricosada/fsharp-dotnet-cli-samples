# F# samples using .NET CLI
 
[F#](http://fsharp.org/) and the [.NET CLI](http://dotnet.github.io/) working together

This repository build F# projects using dotnet/cli from:

| alias     |     |
|-----------|-----|
|`latest`   | Latest dotnet cli binaries [dotnet-win-x64.latest.zip](https://dotnetcli.blob.core.windows.net/dotnet/dev/Binaries/Latest/dotnet-win-x64.latest.zip) |
|`rel-1.0.0`| Clone and build dotnet/cli branch [rel/1.0.0](https://github.com/dotnet/cli/tree/rel/1.0.0) |
|`stabledev`| Clone and build latest cli with working dev f# support (atm is [enricosada/cli branch fix_dotnet_compile_fsc](https://github.com/enricosada/cli/tree/fix_dotnet_compile_fsc) ) |


## Build

The build script download binaries (`scripts/download-cli-binaries`) or clone and build a dotnet/cli repo in specific branch (`scripts/download-cli`)

Same dotnet cli prerequisites (see dotnet cli [Developer guide](https://github.com/dotnet/cli/blob/rel/1.0.0/Documentation/developer-guide.md))

After the build the `scripts/use-dev` add the specific dotnet cli to `PATH`
and run tests (`scripts/run-tests`):

- restore and build `HelloConsole`
- create a new f# console app with `dotnet new --lang f#`, restore and build

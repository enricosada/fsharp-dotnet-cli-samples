# Multiple framework example

The project can be built for .NET 4.6 (`net46`) and .NET Core (`dnxcore50`)

Each framework use:

- global `dependencies`
- specific to framework `dependencies` inside the `frameworks`.`<frameworkName>`
- specific to framework `frameworkAssemblies` inside the `frameworks`.`<frameworkName>`

```json
    "frameworks": {
        "dnxcore50": { 
            "dependencies": {
                "Microsoft.FSharp.Core.netcore": "1.0.0-alpha-151221",
                "NETStandard.Library": "1.0.0-rc2-23811"
            }
        },
        "net46": { 
            "dependencies": {
                "FSharp.Core": "4.0.0.1"
            },
            "frameworkAssemblies": {
            }
        }
    }
```

### Build

`dotnet restore`
`dotnet build` Build both `net46` and `dnxcore50`

To build only a specific framework, use the argument `--framework`

For example to build `net46` only:

`dotnet build --framework net46`

### Run it

`dotnet run` run the default framework (`dnxcore50`)

To run a specific version, use the argument `--framework`

For example to run `net46`:

`dotnet run --framework net46`

### Expected output

#### .NET 4.6

`dotnet run --framework net46`

```
Project HelloMultipleFramework (.NETFramework,Version=v4.6) will be compiled because some of its inputs were newer than its oldest output.
Compiling HelloMultipleFramework for .NETFramework,Version=v4.6

Compilation succeeded.
    0 Warning(s)
    0 Error(s)

Time elapsed 00:00:13.5959189


Hello World!
Hello from .NET 4.6
Location: C:\Windows\Microsoft.NET\Framework64\v4.0.30319\mscorlib.dll
```

#### .NET Core

`dotnet run` (or `dotnet run --framework dnxcore50` )

```
Project HelloMultipleFramework (DNXCore,Version=v5.0) will be compiled because some of its inputs were newer than its oldest output.
Compiling HelloMultipleFramework for DNXCore,Version=v5.0

Compilation succeeded.
    0 Warning(s)
    0 Error(s)

Time elapsed 00:00:05.4592615


Hello World!
Hello from .NET Core
Location: C:\Users\user1\.nuget\packages\runtime.win7-x64.Microsoft.NETCore.Runtime.CoreCLR\1.0.1-rc2-23811\runtimes\win7-x64\native\mscorlib.ni.dll
```

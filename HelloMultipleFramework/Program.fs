// Learn more about F# at http://fsharp.org

open System
open System.Reflection
open System.Diagnostics

[<EntryPoint>]
let main argv = 
    printfn "Hello World!"
    
#if DNXCORE50
    printfn "Hello from .NET Core"
    printfn "Location: %s" (typeof<String>.GetTypeInfo().Assembly.Location)
#endif
#if NET46
    printfn "Hello from .NET 4.6"
    printfn "Location: %s" (typeof<String>.Assembly.Location)
#endif
    
    0 // return an integer exit code

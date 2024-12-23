# swift-log-data

A swift-log backend which using SwiftData to store log.

## Quick Start - SwiftUI

1. Register the model container in the scene that you may logging. 

   Here is an example that regsiter the model in to the main scene.

   ```swift
   import DataLogger
   
   @main
   struct Example_App: App {
       var body: some Scene {
           WindowGroup {
               ContentView()
           }
           .logContainer()
       }
   }
   ```

2. Bootstrap the logger.

   ```swift
   import Logging
   // Initializer in Example_App
   init() {
       LoggingSystem.bootstrap(DataLogger.init)
   }
   ```

3. Use the swift-log API for logging. For more details, please check [swift-log Github Repo](https://github.com/apple/swift-log).

## Read the logs

If you are using SwiftUI, you can use environmental `logActor` to access the logging actor.

```swift
@Environment(\.logActor) var logActor

func getLogs() async throws -> [Log] {
    try await logActor.fetch()
}
```

The model store of logs stored in /Container/Library/Logs

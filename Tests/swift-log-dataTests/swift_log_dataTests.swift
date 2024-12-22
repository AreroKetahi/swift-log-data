import Testing
import Foundation
import Logging
import SwiftData
@testable import swift_log_data

@Test func save() async throws {
    print(defaultURL())
    LoggingSystem.bootstrap(DataLogger.init)
    let logger = Logger(label: "testing-logger")
    let oldCount = try await DataLogger.modelActor.fetch(FetchDescriptor<Log>()).count
    logger.info( "Hello, World!" )
    try await Task.sleep(nanoseconds: 1_000_000_000)
    let logs = try await DataLogger.self.modelActor.fetch(FetchDescriptor<Log>())
    #expect(logs.count == 1)
}

fileprivate func defaultURL() -> URL {
    let toolDirectory = CommandLine.arguments[0]
    let url = URL(string: toolDirectory)
    let name = url?.lastPathComponent ?? toolDirectory
    
    let current = URL(filePath: FileManager.default.currentDirectoryPath)
    return current.appending(component: "\(name)-log")
}

//
//  Container.swift
//  swift-log-data
//
//  Created by Akivili Collindort on 2024/12/22
//

import SwiftData
import Foundation

public struct LogContainer {
    public var container: ModelContainer
    
    static var `default`: Self {
        Self.default(url: defaultURL())
    }
    
    static func `default`(url: URL) -> Self {
        let container = try! ModelContainer(
            for: .init([Log.self]),
            configurations: [.init(url: url)]
        )
        return LogContainer(container: container)
    }
}

fileprivate func isRunInCommandLine() -> Bool {
    #if SWIFT_PACKAGE
    true
    #else
    false
    #endif
    
}

fileprivate func defaultURL() -> URL {
    if isRunInCommandLine() {
        let toolDirectory = CommandLine.arguments[0]
        let url = URL(string: toolDirectory)
        let name = url?.lastPathComponent ?? toolDirectory
        
        let current = URL(filePath: FileManager.default.currentDirectoryPath)
        return current.appending(component: "\(name)-log")
    } else {
        let applicationContainer = FileManager.default.urls(
            for: .libraryDirectory,
            in: .userDomainMask
        ).first!
        return applicationContainer.appending(component: "Logs")
    }
}

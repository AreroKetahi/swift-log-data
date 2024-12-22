//
//  LogHandler.swift
//  swift-log-data
//
//  Created by Akivili Collindort on 2024/12/22
//

import Logging
import class Foundation.NSLock
import SwiftData

public struct DataLogger {
    var label: String
    
    private static let overrideLock = NSLock()
    nonisolated(unsafe)
    private static var globalOverrideLogLevel: Logger.Level?
    
    private var _logLevel: Logger.Level = .info
    
    public var metadata: Logger.Metadata = .init()
    
    static let modelActor: LoggingModelActor = LoggingModelActor(
        modelContainer: LogContainer.default.container
    )
    
    static let defaultContainer = LogContainer.default.container
    
    init(label: String) {
        self.label = label
    }
}

extension DataLogger: LogHandler {
    public var logLevel: Logger.Level {
        get {
            Self.overrideLock.lock()
            defer { Self.overrideLock.unlock() }
            return Self.globalOverrideLogLevel ?? self._logLevel
        }
        set {
            self._logLevel = newValue
        }
    }
    
    public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        get { metadata[key] }
        set { metadata[key] = newValue }
    }
    
    public func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        Task {
            let newLog = Log(
                date: .now,
                level: level,
                message: message,
                metadata: metadata,
                source: source,
                file: file,
                function: function,
                line: line
            )
            await Self.modelActor.insert(newLog)
            try? await Self.modelActor.save()
        }
    }
}

extension DataLogger {
    public static func overrideGlobalLogLevel(_ logLevel: Logger.Level) {
        Self.overrideLock.lock()
        defer { Self.overrideLock.unlock() }
        Self.globalOverrideLogLevel = logLevel
    }
}

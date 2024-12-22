//
//  LogModel.swift
//  swift-log-data
//
//  Created by Akivili Collindort on 2024/12/22
//

import SwiftData
import Foundation
import Logging

@Model
public class Log: @unchecked Sendable {
    var date: Date
    var level: Logger.Level
    var message: String
    var metadata: String?
    var source: String
    var file: String
    var function: String
    var line: UInt
    
    init(
        date: Date,
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata? = nil,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        self.date = date
        self.level = level
        self.message = message.description
        self.metadata = metadata?.description
        self.source = source
        self.file = file
        self.function = function
        self.line = line
    }
}

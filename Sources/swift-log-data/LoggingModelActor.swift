//
//  LoggingModelActor.swift
//  swift-log-data
//
//  Created by Akivili Collindort on 2024/12/22
//

import SwiftData

@ModelActor
public actor LoggingModelActor {
    func insert(_ model: Log) {
        self.modelContext.insert(model)
    }
    
    public func fetch(_ descriptor: FetchDescriptor<Log> = .init()) throws -> [Log] {
        try self.modelContext.fetch(descriptor)
    }
    
    func delete(_ model: Log) {
        self.modelContext.delete(model)
    }
    
    public func reset() throws {
        try self.modelContext.delete(model: Log.self)
    }
    
    func save() throws {
        try self.modelContext.save()
    }
    
    func rollback() {
        self.modelContext.rollback()
    }
}

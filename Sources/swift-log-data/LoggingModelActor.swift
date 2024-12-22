//
//  LoggingModelActor.swift
//  swift-log-data
//
//  Created by Akivili Collindort on 2024/12/22
//

import SwiftData

@ModelActor
public actor LoggingModelActor {
    func insert<T: PersistentModel>(_ model: T) {
        self.modelContext.insert(model)
    }
    
    public func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        try self.modelContext.fetch(descriptor)
    }
    
    func delete<T: PersistentModel>(_ model: T) {
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

//
//  SwiftUIModifier.swift
//  swift-log-data
//
//  Created by Akivili Collindort on 2024/12/23
//

import SwiftUI
import SwiftData

struct LoggingModelContainerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.modelContainer(LogContainer.default.container)
    }
}

extension View {
    public func logContainer() -> some View {
        self.modifier(LoggingModelContainerModifier())
    }
}

extension Scene {
    public func logContainer() -> some Scene {
        self.modelContainer(LogContainer.default.container)
    }
}

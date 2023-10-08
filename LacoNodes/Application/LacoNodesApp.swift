//
//  LacoNodesApp.swift
//  LacoNodes
//
//  Created by Данил Терлецкий on 30.09.2023.
//

import SwiftUI
import SwiftData

@main
struct LacoNodesApp: App {

    private let modelContainer: ModelContainer

    init() {
        do {
            self.modelContainer = try ModelContainer(for: Node.self, configurations: ModelConfiguration(for: Node.self, isStoredInMemoryOnly: true))
        } catch {
            fatalError("Failed to initialise model container")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NodeView(node: Node(name: "Root"))
            }
        }
        .modelContainer(modelContainer)
    }
}

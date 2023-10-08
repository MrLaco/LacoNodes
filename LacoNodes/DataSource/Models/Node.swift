//
//  Node.swift
//  LacoNodes
//
//  Created by Данил Терлецкий on 30.09.2023.
//

import Foundation
import SwiftData

@Model
final class Node: Identifiable, ObservableObject {
    var id = UUID()

    var name: String

    @Relationship(deleteRule: .cascade)
    var children: [Node] = []

    var parent: Node?

    init(name: String) {
        self.name = name
    }
}

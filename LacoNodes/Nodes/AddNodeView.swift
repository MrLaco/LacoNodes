//
//  AddNodeView.swift
//  LacoNodes
//
//  Created by Данил Терлецкий on 07.10.2023.
//

import SwiftUI

struct AddNodeView: View {
    @Environment(\.modelContext) private var modelContext

    @ObservedObject var nodeViewModel: NodeViewModel = .init()
    var nodeView: NodeView

    var body: some View {
        Form {
            Section() {
                HStack {
                    Text("Generated name: ").bold() + Text("\(nodeViewModel.nodeName)")
                    Spacer()
                    Button("Generate") {
                        nodeViewModel.generateRandomName()
                    }
                }
            }

            Section() {
                Button("Save") {
                    let node = Node(name: nodeViewModel.nodeName)
                    modelContext.insert(node)

                    nodeView.node.children.append(node)
                    node.parent = nodeView.node

                    nodeView.showAddNodeView.toggle()
                }
                .disabled(!nodeViewModel.isNodeNameValid)

                Button("Cancel", role: .cancel, action: {
                    nodeView.showAddNodeView.toggle()
                })
                .tint(.red)
            }
        }
    }
}

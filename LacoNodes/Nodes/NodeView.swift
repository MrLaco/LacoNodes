//
//  NodesView.swift
//  LacoNodes
//
//  Created by Данил Терлецкий on 30.09.2023.
//

import SwiftUI
import SwiftData

struct NodeView: View {
    @Environment(\.modelContext) private var modelContext
    @State var showAddNodeView = false

    var isEditButtonDisabled: Bool {
        node.children.count == 0
    }

    var node: Node

    var body: some View {
        List {
            ForEach(node.children, id: \.self) { childNode in
                NavigationLink {
                    NodeView(node: childNode)
                } label: {
                    Text(childNode.name)
                }
            }
            .onDelete { indexSet in
                let nodesToDelete = node.children.enumerated().filter { index, _ in
                    indexSet.contains(index)
                }.map { _, node in
                    return node
                }

                nodesToDelete.forEach {
                    modelContext.delete($0)
                }

                node.children.remove(atOffsets: indexSet)
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    showAddNodeView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showAddNodeView, content: {
                    AddNodeView(nodeView: self)
                })
            }
            ToolbarItem {
                EditButton()
                    .tint(.red)
                    .disabled(isEditButtonDisabled)
            }
        }
        .navigationTitle(node.name)
    }
}

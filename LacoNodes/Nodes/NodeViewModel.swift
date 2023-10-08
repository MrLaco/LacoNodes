//
//  NodeViewModel.swift
//  LacoNodes
//
//  Created by Данил Терлецкий on 07.10.2023.
//

import SwiftUI
import Combine

final class NodeViewModel: ObservableObject {

    @Published var nodeName = ""
    @Published var isNodeNameValid = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $nodeName
            .map { newName in
                return newName.count >= 8
            }
            .assign(to: \.isNodeNameValid, on: self)
            .store(in: &cancellables)
    }
}

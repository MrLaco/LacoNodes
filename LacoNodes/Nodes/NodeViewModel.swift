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

    private let randomNameSubject = PassthroughSubject<Void, Never>()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        randomNameSubject
            .map { _ in
                let randomBytes = (0..<10).map { _ in
                    UInt8.random(in: 0...255)
                }
                let hexString = randomBytes.map {
                    String(format: "%02x", $0)
                }.joined()

                return hexString
            }
            .assign(to: \.nodeName, on: self)
            .store(in: &cancellables)

        $nodeName
            .map { newName in
                return newName.count > 0 ? true : false
            }
            .assign(to: \.isNodeNameValid, on: self)
            .store(in: &cancellables)
    }

    func generateRandomName() {
        randomNameSubject.send()
    }
}

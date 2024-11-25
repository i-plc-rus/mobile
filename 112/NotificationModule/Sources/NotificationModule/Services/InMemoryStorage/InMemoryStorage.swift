//
//  InMemoryStorage.swift
//  
//
//  Created by anbushmanov on 02.11.2024.
//

import Foundation

final class InMemoryStorage: IInMemoryStorage {
    // MARK: - Properties

    private var storage: [InMemoryKey: Any] = [:]
    private let queue = DispatchQueue(label: "com.notification.module.in.memory.storage", attributes: .concurrent)

    // MARK: - Functions

    func getValue<T>(from key: InMemoryKey) -> T? {
        var result: T?
        queue.sync {
            result = storage[key] as? T
        }

        return result
    }

    func saveValue(_ value: some Any, for key: InMemoryKey) {
        queue.async(flags: .barrier) {
            self.storage[key] = value
        }
    }
}

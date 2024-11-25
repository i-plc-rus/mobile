//
//  IInMemoryStorage.swift
//  
//
//  Created by anbushmanov on 02.11.2024.
//

import Foundation

protocol IInMemoryStorage {
    func getValue<T>(from key: InMemoryKey) -> T?
    func saveValue(_ value: some Any, for key: InMemoryKey)
}

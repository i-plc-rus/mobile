//
//  Bool+Extension.swift
//  
//
//  Created by anbushmanov on 04.11.2024.
//

import Foundation

extension Bool {
    func toString() -> String {
        self.description
    }
    
    func toInt() -> Int {
        if self {
            return 1
        } else {
            return 0
        }
    }
}

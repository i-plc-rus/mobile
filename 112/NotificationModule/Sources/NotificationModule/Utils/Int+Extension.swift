//
//  Int+Extension.swift
//  
//
//  Created by anbushmanov on 04.11.2024.
//

import Foundation

extension Int {
    func toBool() -> Bool? {
        switch self {
        case 0:
            return false
        default:
            return true
        }
    }
}

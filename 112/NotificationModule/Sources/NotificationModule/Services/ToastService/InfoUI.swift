//
//  InfoUI.swift
//
//
//  Created by anbushmanov on 28.10.2024.
//

import Foundation
import SwiftUI

/// Информационная модель, для отображения тостов или полноэкранных ошибок.
struct InfoUI: Identifiable, Equatable {
    let id = UUID().uuidString
    let icon: ToastIconUI
    let title: String
    let description: String?
    
    struct ToastIconUI: Equatable {
        let name: String
        let color: Color
    }
}

extension InfoUI {
    static func success(_ title: String, description: String? = nil) -> InfoUI {
        .init(
            icon: .init(
                name: "checkmark.circle.fill",
                color: .green
            ),
            title: title,
            description: description
        )
    }
    
    static func warning(_ title: String, description: String?) -> InfoUI {
        .init(
            icon: .init(
                name: "exclamationmark.triangle.fill",
                color: .yellow
            ),
            title: title,
            description: description
        )
    }
    static func error(_ title: String, description: String?) -> InfoUI {
        .init(
            icon: .init(
                name: "xmark.circle.fill",
                color: .red
            ),
            title: title,
            description: description
        )
    }
}

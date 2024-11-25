//
//  OptionUI.swift
//  
//
//  Created by anbushmanov on 28.10.2024.
//

import Foundation

/// UI модель для ячейки настроек с переключателем
struct OptionUI: Identifiable {
    let id: String
    let systemIcon: String
    let title: String
    let subtitle: String?
    var isSelected: Bool
}

//
//  UserSettings.swift
//  
//
//  Created by anbushmanov on 04.11.2024.
//

import Foundation

/// Domain модель пользовательских настроек
struct UserSettings {
    var email: String
    var phone: String
    var emailIsActive: Bool
    var smsIsActive: Bool
    var pushIsActive: Bool
}

//
//  NotificationSettingsInput.swift
//  
//
//  Created by anbushmanov on 28.10.2024.
//

import Foundation

enum NotificationSettingsInput {
    case onAppear
    case optionTapped(OptionUI)
    case refreshButtonTapped
    case sendEmailTapped
    case sendPhoneTapped
    case textFieldUnfocused
}

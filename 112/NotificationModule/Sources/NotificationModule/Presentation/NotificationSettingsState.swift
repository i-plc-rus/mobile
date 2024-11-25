//
//  NotificationSettingsState.swift
//  
//
//  Created by anbushmanov on 28.10.2024.
//

import Foundation

struct NotificationSettingsState {
    
    enum ContentState {
        case loading
        case loaded
        case failed(InfoUI)
    }
    
    var contentState: ContentState = .loading
    
    var phoneText: String = ""
    var savedPhone: String = ""
    var phoneIsValid: Bool {
        phoneText == savedPhone
    }
    var phoneIsLoading: Bool = false
    
    var emailText: String = ""
    var savedEmail: String = ""
    var emailIsValid: Bool {
        emailText == savedEmail
    }
    var emailIsLoading: Bool = false
    
    var options: [OptionUI] = []
}

extension String {
    static let smsID = "smsID"
    static let pushID = "pushID"
    static let emailID = "emailID"
}

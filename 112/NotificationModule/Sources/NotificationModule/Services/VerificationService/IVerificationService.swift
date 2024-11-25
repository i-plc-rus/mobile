//
//  IVerificationService.swift
//  
//
//  Created by anbushmanov on 02.11.2024.
//

import Foundation

protocol IVerificationService {
    func isValidEmail(_ email: String) -> Bool
    func isValidPhoneNumber(_ number: String) -> Bool
}

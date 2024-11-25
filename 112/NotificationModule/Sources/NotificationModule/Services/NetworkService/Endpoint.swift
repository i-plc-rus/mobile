//
//  Endpoint.swift
//  
//
//  Created by anbushmanov on 04.11.2024.
//

import Foundation

enum Endpoint {
    static let createUser = "/user"
    
    static func loginUser(username: String, password: String) -> String {
        "/user/login?username=\(username)h&password=\(password)"
    }
    
    static func getUser(username: String) -> String {
        "/user/\(username)"
    }
    
    static func updateUser(username: String) -> String {
        "/user/\(username)"
    }
}

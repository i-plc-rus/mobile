//
//  UserSettingsDTO.swift
//  
//
//  Created by anbushmanov on 04.11.2024.
//

import Foundation

/// Модели пользователя для работы с сетью
enum UserSettingsDTO {
    struct Response: Decodable {
        let id: Int?
        let username: String?
        let password: String?
        
        let email: String?
        let phone: String?
        let emailIsActive: Bool?
        let smsIsActive: Bool?
        let pushIsActive: Bool?
        
        // Так как изначально, данные имеют не совсем тот вид, который
        // нам нужен, переопределяем название получаемых полей через ключи
        enum CodingKeys: String, CodingKey {
            case id
            case username
            case password
            
            case email
            case phone
            case emailIsActive = "firstName"
            case smsIsActive = "lastName"
            case pushIsActive = "userStatus"
        }
        
        // А затем вносим небольшие изменения в декодер
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<UserSettingsDTO.Response.CodingKeys> = try decoder.container(keyedBy: UserSettingsDTO.Response.CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: UserSettingsDTO.Response.CodingKeys.id)
            self.username = try container.decodeIfPresent(String.self, forKey: UserSettingsDTO.Response.CodingKeys.username)
            self.password = try container.decodeIfPresent(String.self, forKey: UserSettingsDTO.Response.CodingKeys.password)
            self.email = try container.decodeIfPresent(String.self, forKey: UserSettingsDTO.Response.CodingKeys.email)
            self.phone = try container.decodeIfPresent(String.self, forKey: UserSettingsDTO.Response.CodingKeys.phone)
            self.emailIsActive = try container.decodeIfPresent(String.self, forKey: UserSettingsDTO.Response.CodingKeys.emailIsActive)?.toBool()
            self.smsIsActive = try container.decodeIfPresent(String.self, forKey: UserSettingsDTO.Response.CodingKeys.smsIsActive)?.toBool()
            self.pushIsActive = try container.decodeIfPresent(Int.self, forKey: UserSettingsDTO.Response.CodingKeys.pushIsActive)?.toBool()
        }
    }
    
    struct Request: Encodable {
        // Данные пользователя, которые в обычной ситуации приходят из вне,
        // Но тут они прописаны жестко, чтобы нам всегда тестировать одного
        // и того же пользователя, а так же не прописывать их постоянно
        let id: Int = 2252896909
        let username: String = "Y8K86NublIe6U3B"
        let password: String = "KGjqw6R3uCw1YEm"
        
        let email: String
        let phone: String
        let firstName: String
        let lastName: String
        let userStatus: Int
        
        init(
            email: String,
            phone: String,
            emailIsActive: Bool,
            smsIsActive: Bool,
            pushIsActive: Bool
        ) {
            self.email = email
            self.phone = phone
            self.firstName = emailIsActive.toString()
            self.lastName = smsIsActive.toString()
            self.userStatus = pushIsActive.toInt()
        }
        
        init(_ userSettings: UserSettings) {
            self.email = userSettings.email
            self.phone = userSettings.phone
            self.firstName = userSettings.emailIsActive.toString()
            self.lastName = userSettings.smsIsActive.toString()
            self.userStatus = userSettings.pushIsActive.toInt()
        }
    }
}

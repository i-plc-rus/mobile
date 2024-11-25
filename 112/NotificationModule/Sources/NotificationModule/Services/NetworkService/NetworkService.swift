//
//  NetworkService.swift
//  
//
//  Created by anbushmanov on 31.10.2024.
//

import Foundation

final class NetworkService {
    
    init() {}
    
    private let baseURL = "https://petstore.swagger.io/v2"
    private let mockUser = UserSettingsDTO.Request.mock
    
    @discardableResult
    private func fetchPlainRequest(
        endpoint: String,
        method: RequestMethod,
        encodableData: Encodable? = nil
    ) async throws -> Data {
        // Создаем url
        guard let url = URL(string: baseURL + endpoint) else { throw NetworkError.invalidURL }
        
        // Создаем и конфигурируем request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Добавляем тело request'a через encodable модель
        if let encodableData {
            do {
                request.httpBody = try JSONEncoder().encode(encodableData)
            } catch {
                throw NetworkError.invalidEncodableData
            }
        }
        
        // Отправляем
        let(data, response) = try await URLSession.shared.data(for: request)
        
        // Далее проверяем полученные данные
        guard let httpResponse = response as? HTTPURLResponse else  { throw NetworkError.invalidResponse}
        
        guard httpResponse.statusCode >= 200, httpResponse.statusCode < 300 else { throw NetworkError.requestFailed(httpResponse.statusCode) }
        
        return data
    }
    
    private func fetchRequest<T: Decodable>(
        endpoint: String,
        method: RequestMethod,
        encodableData: Encodable? = nil
    ) async throws -> T {
        let data = try await fetchPlainRequest(
            endpoint: endpoint,
            method: method,
            encodableData: encodableData
        )
    
        // Парсим полученные данные
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch {
            throw NetworkError.parsingError(error)
        }
    }
}

extension NetworkService: INetworkService {
    /// Получение данных пользователя
    func getUserSettings() async throws -> UserSettings {
        // Из-за того, что на используемое api нет толком документации, мы не
        // можем гарантировать, что пользователь созданный вчера, будет существовать
        // и в последующем, поэтому:
        
        do {
            // Попытка залогинить пользователя, так как вносить изменения в юзера можно
            // только в залогиненном состоянии
            try await loginUser()
            
            // Загружаем данные пользователя
            return try await loadUserSettings()
        } catch NetworkError.requestFailed {
            // В случае неудачного входа, или загрузки данных,
            // Создаем пользователя по новой, используя мокового
            // пользователя, логиним его и получаем настроки
            try await createUser()
            try await loginUser()
            return try await loadUserSettings()
        }
    }
    
    /// Обновление данных пользователя.
    func sendUserSettings(_ data: UserSettingsDTO.Request) async throws {
        // Так же из-за отсутствия документации, отправляем всю модель
        // целиком, так как это ведет к наиболее прогнозируемому результату
        
        try await fetchPlainRequest(
            endpoint: Endpoint.updateUser(username: mockUser.username),
            method: .put,
            encodableData: data
        )
    }
}

private extension NetworkService {
    /// Загрузка данных пользователя их валидация и маппинг в домейн модель
    private func loadUserSettings() async throws -> UserSettings {
        let dto: UserSettingsDTO.Response = try await fetchRequest(
            endpoint: Endpoint.getUser(username: mockUser.username),
            method: .get
        )
        
        // Проверяем что нам пришли нужные данные
        guard
            let email = dto.email,
            let phone = dto.phone,
            let emailIsActive = dto.emailIsActive,
            let smsIsActive = dto.smsIsActive,
            let pushIsActive = dto.pushIsActive
        else {
            throw NetworkError.emptyResponse
        }
             
        return UserSettings(
            email: email,
            phone: phone,
            emailIsActive: emailIsActive,
            smsIsActive: smsIsActive,
            pushIsActive: pushIsActive
        )
    }
    
    /// Создание пользователя из мок данных
    private func createUser() async throws {
        try await fetchPlainRequest(endpoint: Endpoint.createUser, method: .post, encodableData: mockUser)
    }
    
    /// Логин пользователя из мок данных
    private func loginUser() async throws {
        try await fetchPlainRequest(
            endpoint: Endpoint.loginUser(
                username: mockUser.username,
                password: mockUser.password
            ),
            method: .get
        )
    }
}

private extension UserSettingsDTO.Request {
    /// Моковый пользователь, используемы для демонстрации работы модуля
    static let mock: UserSettingsDTO.Request = .init(
        email: "",
        phone: "",
        emailIsActive: false,
        smsIsActive: false,
        pushIsActive: false
    )
}


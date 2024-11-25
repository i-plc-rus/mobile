//
//  INetworkService.swift
//  
//
//  Created by anbushmanov on 02.11.2024.
//

import Foundation

protocol INetworkService {
    func getUserSettings() async throws -> UserSettings
    func sendUserSettings(_ data: UserSettingsDTO.Request) async throws
}

//
//  NotificationModuleAssembly.swift
//  
//
//  Created by anbushmanov on 30.10.2024.
//

import Foundation
import SwiftUI

public final class NotificationModuleAssembly {
    
    private let serviceContainer: IServiceContainer
    
    public init() {
        serviceContainer = ServiceContainer()
    }
}

extension NotificationModuleAssembly: INotificationModuleAssembly {
    public func assemble() -> NotificationSettingsView {
        let viewModel = NotificationSettingsViewModel(
            toastService: serviceContainer.toastService,
            networkService: serviceContainer.networkService,
            inMemoryStorage: serviceContainer.inMemoryStorage,
            verificationService: serviceContainer.verificationService
        )
        
        return NotificationSettingsView(
            viewModel: viewModel,
            toastViewAssembly: self
        )
    }
}

extension NotificationModuleAssembly: IToastViewAssembly {
    func assemble() -> ToastView {
        return ToastView(toastEventSender: serviceContainer.toastEventSender)
    }
}

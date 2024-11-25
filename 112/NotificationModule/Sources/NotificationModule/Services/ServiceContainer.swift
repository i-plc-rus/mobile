//
//  ServiceContainer.swift
//  
//
//  Created by anbushmanov on 30.10.2024.
//

import Foundation

final class ServiceContainer: IServiceContainer {
    private let _toastService: IToastService & IToastEventSender
    
    let toastService: IToastService
    let toastEventSender: IToastEventSender
    let networkService: INetworkService
    let inMemoryStorage: IInMemoryStorage
    let verificationService: IVerificationService
    
    init(
        _toastService: IToastService & IToastEventSender = ToastService(),
        networkService: INetworkService = NetworkService(),
        inMemoryStorage: IInMemoryStorage = InMemoryStorage(),
        verificationService: IVerificationService = VerificationService()
    ) {
        self._toastService = _toastService
        self.toastService = _toastService
        self.toastEventSender = _toastService
        self.networkService = networkService
        self.inMemoryStorage = inMemoryStorage
        self.verificationService = verificationService
    }
}

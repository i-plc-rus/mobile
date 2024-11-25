//
//  IServiceContainer.swift
//  
//
//  Created by anbushmanov on 30.10.2024.
//

import Foundation

protocol IServiceContainer {
    var toastService: IToastService { get }
    var toastEventSender: IToastEventSender { get }
    var networkService: INetworkService { get }
    var inMemoryStorage: IInMemoryStorage { get }
    var verificationService: IVerificationService { get }
}

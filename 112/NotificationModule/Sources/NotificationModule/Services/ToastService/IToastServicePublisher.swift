//
//  IToastEventSender.swift
//  
//
//  Created by anbushmanov on 30.10.2024.
//

import Foundation
import Combine

protocol IToastEventSender {
    var trigger: AnyPublisher<InfoUI?, Never> { get }
}

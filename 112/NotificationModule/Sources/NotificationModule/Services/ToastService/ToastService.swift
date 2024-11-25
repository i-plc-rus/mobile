//
//  ToastService.swift
//  
//
//  Created by anbushmanov on 30.10.2024.
//

import Foundation
import Combine

final class ToastService: IToastEventSender {
    private let _trigger: PassthroughSubject<InfoUI?, Never>
    private var toastTask: Task<Void, Error>?
    
    var trigger: AnyPublisher<InfoUI?, Never> {
        _trigger.eraseToAnyPublisher()
    }
    
    init() {
        self._trigger = .init()
    }
}

extension ToastService: IToastService {
    func show(_ error: InfoUI) {
        toastTask = nil
        _trigger.send(nil)
        
        toastTask = Task { @MainActor in
            _trigger.send(error)
            
            try await Task.sleep(nanoseconds: UInt64(3.0) * NSEC_PER_SEC)
            
            try Task.checkCancellation()
            
            _trigger.send(nil)
        }
    }
}

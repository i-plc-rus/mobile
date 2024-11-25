//
//  SwiftUIView.swift
//  
//
//  Created by anbushmanov on 28.10.2024.
//

import SwiftUI

public struct NotificationSettingsView: View {
    
    @StateObject private var viewModel: NotificationSettingsViewModel
    private let toastViewAssembly: IToastViewAssembly
    
    init(
        viewModel: NotificationSettingsViewModel,
        toastViewAssembly: IToastViewAssembly
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.toastViewAssembly = toastViewAssembly
    }
    
    public var body: some View {
        ZStack {
            Colors.appWhite
                .ignoresSafeArea()
            
            switch viewModel.state.contentState {
            case .loading:
                RingProgressView(.medium)
                
            case .loaded:
                ContentView()
                
            case .failed(let info):
                ErrorView(info: info)
            }
        }
        .environmentObject(viewModel)
        .overlay(
            toastViewAssembly.assemble()
        )
        .onAppear {
            Task {
                await viewModel.trigger(.onAppear)
            }
        }
    }
}

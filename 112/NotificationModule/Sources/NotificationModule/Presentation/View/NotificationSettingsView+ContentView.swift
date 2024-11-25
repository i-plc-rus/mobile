//
//  NotificationSettingsView+ContentView.swift
//  
//
//  Created by anbushmanov on 28.10.2024.
//

import SwiftUI

extension NotificationSettingsView {
    struct ContentView: View {
        
        @EnvironmentObject private var viewModel: NotificationSettingsViewModel
        
        var body: some View {
            ScrollView {
                VStack {
                    titleView(Strings.emailSectionTitle)
                    
                    TextCellView(
                        text: $viewModel.state.emailText,
                        isLoading: $viewModel.state.emailIsLoading,
                        icon: "at",
                        placeholder: Strings.emailTextPlaceholder,
                        isValid: viewModel.state.emailIsValid,
                        format: .email
                    ) {
                        Task {
                            await viewModel.trigger(.sendEmailTapped)
                        }
                    }
                    
                    titleView(Strings.phoneSectionTitle)
                    
                    TextCellView(
                        text: $viewModel.state.phoneText,
                        isLoading: $viewModel.state.phoneIsLoading,
                        icon: "phone",
                        placeholder: Strings.phoneTextPlaceholder,
                        isValid: viewModel.state.phoneIsValid,
                        format: .phone
                    ) {
                        Task {
                            await viewModel.trigger(.sendPhoneTapped)
                        }
                    }
                    
                    titleView(Strings.settingsSectionTitle)
                    
                    ForEach(viewModel.state.options) { option in
                        CellView(option: option)
                    }
                }
                .padding(.horizontal, 16.0)
                .padding(.vertical, 8.0)
            }
        }
        
        private func titleView(_ title: String) -> some View {
            Text(title)
                .font(Fonts.sys20Bold)
                .foregroundStyle(Colors.font)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

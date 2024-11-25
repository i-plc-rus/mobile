//
//  NotificationSettingsView+ErrorView.swift
//  
//
//  Created by anbushmanov on 31.10.2024.
//

import SwiftUI

extension NotificationSettingsView {
    struct ErrorView: View {
        
        @EnvironmentObject private var viewModel: NotificationSettingsViewModel
        
        private let info: InfoUI
        
        init(info: InfoUI) {
            self.info = info
        }
        
        var body: some View {
            VStack(spacing: 0.0) {
                Image(systemName: info.icon.name)
                    .resizable()
                    .foregroundStyle(info.icon.color)
                    .frame(width: 100.0, height: 100.0)
                    .padding(.bottom, 20.0)
                
                Text(info.title)
                    .font(Fonts.sys25Bold)
                    .foregroundStyle(Colors.font)
                
                if let description = info.description {
                    Text(description)
                        .font(Fonts.sys17)
                        .foregroundStyle(Colors.secondaryFont)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5.0)
                }
                
                Button {
                    Task {
                        await viewModel.trigger(.refreshButtonTapped)
                    }
                } label: {
                    Text(Strings.refresh)
                        .font(Fonts.sys15Semibold)
                        .foregroundStyle(Colors.appWhite)
                        .padding(.horizontal, 16.0)
                        .padding(.vertical, 8.0)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(Colors.appGreen)
                        )
                }
                .padding(.top, 30.0)
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

//
//  NotificationSettingsView+Cell.swift
//
//
//  Created by anbushmanov on 28.10.2024.
//

import SwiftUI

extension NotificationSettingsView {
    struct CellView: View {
        
        @EnvironmentObject private var viewModel: NotificationSettingsViewModel
        
        private let option: OptionUI
        
        init(
            option: OptionUI
        ) {
            self.option = option
        }
        
        var body: some View {
            Button {
                Task {
                    await viewModel.trigger(.optionTapped(option))
                }
            } label: {
                HStack(spacing: 16.0) {
                    Image(systemName: option.systemIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Colors.appGreen)
                        .frame(width: 25.0, height: 25.0)
                    
                    
                    Toggle(isOn: .constant(option.isSelected), label: {
                        VStack(alignment: .leading) {
                            Text(option.title)
                                .font(Fonts.sys15)
                                .foregroundStyle(Colors.font)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if let description = option.subtitle {
                                Text(description)
                                    .font(Fonts.sys10)
                                    .foregroundStyle(Colors.secondaryFont)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .multilineTextAlignment(.leading)
                    })
                    .tint(Colors.appGreen)
                }
                .padding(.bottom, 10.0)
                .overlay(
                    Rectangle()
                        .fill(Colors.appLightGray)
                        .frame(height: 0.5)
                        .opacity(option.id != viewModel.state.options.last?.id ? 1.0 : 0.0)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.trailing, -16.0)
                        .padding(.leading, 41.0)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

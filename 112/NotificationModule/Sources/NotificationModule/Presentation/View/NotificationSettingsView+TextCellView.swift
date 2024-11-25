//
//  NotificationSettingsView+TextCellView.swift
//
//
//  Created by anbushmanov on 31.10.2024.
//

import SwiftUI

extension NotificationSettingsView {
    struct TextCellView: View {
        
        @EnvironmentObject private var viewModel: NotificationSettingsViewModel
        
        @Binding private var text: String
        @Binding private var isLoading: Bool
        private let icon: String
        private let placeholder: String
        private let isValid: Bool
        private let format: CustomTextFieldView.FormatStyle
        private let action: () -> Void
        
        init(
            text: Binding<String>,
            isLoading: Binding<Bool>,
            icon: String,
            placeholder: String,
            isValid: Bool,
            format: CustomTextFieldView.FormatStyle,
            action: @escaping () -> Void
        ) {
            self._text = text
            self._isLoading = isLoading
            self.icon = icon
            self.placeholder = placeholder
            self.isValid = isValid
            self.action = action
            self.format = format
        }
        
        var body: some View {
            HStack(spacing: 16.0) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Colors.appGreen)
                    .frame(width: 25.0, height: 25.0)
                
                CustomTextFieldView(
                    text: $text,
                    placeholder: placeholder,
                    formatStyle: format
                ) {
                    Task {
                        await viewModel.trigger(.textFieldUnfocused)
                    }
                }
                
                if !text.isEmpty {
                    if isLoading {
                        RingProgressView(.small)
                    } else {
                        if isValid {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                                .foregroundStyle(Colors.appGreen)
                        } else {
                            Button {
                                action()
                            } label: {
                                Image(systemName: "arrowshape.up.circle")
                                    .resizable()
                                    .frame(width: 20.0, height: 20.0)
                                    .foregroundStyle(Colors.secondaryFont)
                            }
                        }
                    }
                } else {
                    Color.clear
                        .frame(width: 20.0, height: 20.0)
                }
            }
        }
    }
}

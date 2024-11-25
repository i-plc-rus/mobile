//
//  SwiftUIView.swift
//  
//
//  Created by anbushmanov on 31.10.2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    enum FormatStyle: String {
        case phone = "+X (XXX) XXX XX XX"
        case email
        
        var maxSymbolsAmount: Int {
            switch self {
            case .phone:
                11
            case .email:
                100
            }
        }
        
        var keyboardStyle: UIKeyboardType {
            switch self {
            case .phone:
                    .numberPad
            case .email:
                    .default
            }
        }
    }
    
    @Binding private var text: String
    private let placeholder: String
    private let formatStyle: FormatStyle
    private let unfocusedAction: () -> Void
    
    private var formattedText: String {
        switch formatStyle {
        case .phone:
            text.format(with: formatStyle.rawValue)
        case .email:
            text
        }
    }
    
    
    @FocusState var isFocused: Bool
    
    init(
        text: Binding<String>,
        placeholder: String,
        formatStyle: FormatStyle = .email,
        unfocusedAction: @escaping () -> Void
    ) {
        self._text = text
        self.placeholder = placeholder
        self.formatStyle = formatStyle
        self.unfocusedAction = unfocusedAction
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .font(Fonts.sys17)
                .foregroundStyle(.clear)
                .focused($isFocused)
                .tint(.clear)
                .keyboardType(formatStyle.keyboardStyle)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .allowsHitTesting(false)
            
            Text(formattedText)
                .font(Fonts.sys17)
                .foregroundStyle(Colors.font)
            
            if text.isEmpty {
                Text(placeholder)
                    .font(Fonts.sys15)
                    .foregroundStyle(Colors.secondaryFont)
                    .allowsHitTesting(false)
            }
        }
        .padding(.horizontal, isFocused ? 16.0 : 0.0)
        .padding(.vertical, 10.0)
        .overlay(
            ZStack {
                if isFocused {
                    RoundedRectangle(cornerRadius: 12.0)
                        .stroke(Colors.appGreen, lineWidth: 2.0)
                } else {
                    EmptyView()
                }
            }
                .allowsTightening(false)
        )
        .animation(.linear(duration: 0.1), value: isFocused)
        .onChange(of: text) { newValue in
            if newValue.count > formatStyle.maxSymbolsAmount {
                text = String(newValue.prefix(formatStyle.maxSymbolsAmount))
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
        .onChange(of: isFocused) { _ in
            if !isFocused {
                unfocusedAction()
            }
        }
    }
}

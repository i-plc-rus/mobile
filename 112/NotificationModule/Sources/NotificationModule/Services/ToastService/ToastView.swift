//
//  SwiftUIView.swift
//  
//
//  Created by anbushmanov on 30.10.2024.
//

import SwiftUI

struct ToastView: View {
    
    @State private var toast: InfoUI?
    private let toastEventSender: IToastEventSender
    
    init(
        toastEventSender: IToastEventSender
    ) {
        self.toastEventSender = toastEventSender
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
            
            if let toast {
                Group {
                    HStack(spacing: 16.0) {
                        Image(systemName: toast.icon.name)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(toast.icon.color)
                            .frame(width: 30.0, height: 30.0)
                        
                        VStack(spacing: 5.0) {
                            Text(toast.title)
                                .foregroundStyle(Colors.appWhite)
                                .font(Fonts.sys15)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if let description = toast.description {
                                Text(description)
                                    .foregroundStyle(Colors.appWhite)
                                    .font(Fonts.sys13)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .opacity(0.7)
                            }
                        }
                    }
                    .padding(16.0)
                    .background(
                        RoundedRectangle(cornerRadius: ToastConstants.cornerRadius)
                            .fill(Colors.appDarkGray)
                    )
                    .padding(.top, 4.0)
                    .padding(.horizontal, 8.0)
                }
                .compositingGroup()
                .transition(
                    .move(edge: .top)
                    .combined(with: .opacity)
                )
            }
        }
        .onReceive(toastEventSender.trigger) { toast in
            self.toast = nil
            self.toast = toast
        }
        .animation(.easeOut(duration: 0.35), value: toast)
    }
}

private enum ToastConstants {
    static let cornerRadius = 16.0
}

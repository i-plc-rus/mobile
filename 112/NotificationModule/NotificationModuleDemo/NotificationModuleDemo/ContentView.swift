//
//  ContentView.swift
//  NotificationModuleDemo
//
//  Created by anbushmanov on 02.11.2024.
//

import SwiftUI
import NotificationModule

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink {
                NotificationSettingsView()
            } label: {
                Text("Перейти в настройки\nуведомлений")
                    .font(.system(size: 17.0, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(.blue)
                    )
            }
        }
    }
}

struct NotificationSettingsView: View {
    
    @State private var notificationAssembly: INotificationModuleAssembly = NotificationModuleAssembly()
    
    var body: some View {
        ZStack {
            notificationAssembly.assemble()
        }
        .navigationTitle("Настройки уведомлений")
    }
}

#Preview {
    ContentView()
}

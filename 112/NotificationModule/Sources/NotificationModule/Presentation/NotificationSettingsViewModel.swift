//
//  NotificationSettingsViewModel.swift
//  
//
//  Created by anbushmanov on 28.10.2024.
//

import SwiftUI

final class NotificationSettingsViewModel: ObservableObject {
    
    // Хранилище состояний экрана
    @Published var state: NotificationSettingsState = .init()
    
    private let toastService: IToastService
    private let networkService: INetworkService
    private let inMemoryStorage: IInMemoryStorage
    private let verificationService: IVerificationService
    private var userSettings: UserSettings?
    
    init(
        toastService: IToastService,
        networkService: INetworkService,
        inMemoryStorage: IInMemoryStorage,
        verificationService: IVerificationService
    ) {
        self.toastService = toastService
        self.networkService = networkService
        self.inMemoryStorage = inMemoryStorage
        self.verificationService = verificationService
    }
    
    // "Мост", через который идет общение ВМ с экраном
    func trigger(_ input: NotificationSettingsInput) async {
        switch input {
        case .onAppear, .refreshButtonTapped:
            await loadSettings()
            
        case .optionTapped(let optionUI):
            await updateOptionsState(optionUI)
            
        case .sendEmailTapped:
            await sendEmail()
            
        case .sendPhoneTapped:
            await sendPhoneNumber()
            
        case .textFieldUnfocused:
            await resetTexts()
        }
    }
}


private extension NotificationSettingsViewModel {
    @MainActor
    func resetTexts() {
        state.phoneText = state.savedPhone
        state.emailText = state.savedEmail
    }
    
    @MainActor
    func updateScreen() {
        guard let settings = userSettings else { return }
        
        state.emailText = settings.email
        state.savedEmail = settings.email
        state.phoneText = settings.phone
        state.savedPhone = settings.phone
        state.options = [
            .init(
                id: .smsID,
                systemIcon: "bubble",
                title: Strings.smsTitle,
                subtitle: Strings.smsSubtitle,
                isSelected: settings.smsIsActive
            ),
            
            .init(
                id: .pushID,
                systemIcon: "bell",
                title: Strings.pushTitle,
                subtitle: nil,
                isSelected: settings.pushIsActive
            ),
            
            .init(
                id: .emailID,
                systemIcon: "envelope",
                title: Strings.emailTitle,
                subtitle: Strings.emailSubtitle,
                isSelected: settings.emailIsActive
            )
        ]
    }
    
    @MainActor
    func updateOptionsState(_ option: OptionUI) {
        guard let index = state.options.firstIndex(where: { $0.id == option.id }) else { return }
        
        switch option.id {
        case .emailID:
            userSettings?.emailIsActive.toggle()
            
        case .pushID:
            userSettings?.pushIsActive.toggle()
            
        case .smsID:
            userSettings?.smsIsActive.toggle()
            
        default:
            break
        }
        
        state.options[index].isSelected.toggle()
        updateNewSettings()
    }
}

private extension NotificationSettingsViewModel {
    @MainActor
    func loadSettings() {
        state.contentState = .loading
        
        Task {
            do {
                // Сначала пробуем достать данные из кеша, если они там есть,
                // Выводим их на экран и убираем полноэкранный лоадер
                if let savedSettings: UserSettings = inMemoryStorage.getValue(from: .userSettings) {
                    userSettings = savedSettings
                    updateScreen()
                    state.contentState = .loaded
                }
                
                // Если данные уже были, подгружаем данные в бекграунде,
                // если же нет, то юзер видит полноэкранный лоадер, пока
                // мы загружаем настройки
                let settings = try await networkService.getUserSettings()
                inMemoryStorage.saveValue(settings, for: .userSettings)
                userSettings = settings
                
                updateScreen()
                state.contentState = .loaded
            } catch {
                // В случае проблема с беком, выводим полноэкранную ошибку с кнопкой "Обновить"
                state.contentState = .failed(
                    .error(
                        Strings.somethingWrongTitle,
                        description: Strings.somethingWrongDescription
                    )
                )
            }
        }
    }
    
    @MainActor
    func sendPhoneNumber() {
        // Валидируем номер телефона, и в случае успеха отправляем запрос на обновление
        if verificationService.isValidPhoneNumber("+\(state.phoneText)") {
            state.phoneIsLoading = true
            userSettings?.phone = state.phoneText
            updateNewSettings(needToast: true)
        } else {
            // Если введенный телефон не прошел валидацию, показываем
            // пользователю тост об этом
            toastService.show(
                .warning(
                    Strings.invalidPhoneTitle,
                    description: Strings.invalidPhoneDescription
                )
            )
        }
    }
    
    @MainActor
    func sendEmail() {
        // Тут логика аналогична отправке номера телефона
        if verificationService.isValidEmail(state.emailText) {
            state.emailIsLoading = true
            userSettings?.email = state.emailText
            updateNewSettings(needToast: true)
        } else {
            toastService.show(.warning(Strings.invalidEmailTitle, description: Strings.invalidEmailDescription))
        }
    }
    
    @MainActor
    func updateNewSettings(needToast: Bool = false) {
        guard let userSettings = userSettings else { return }
        
        Task {
            do {
                // Создаем DTO модель с новыми данными и отправляем ее
                let data: UserSettingsDTO.Request = .init(userSettings)
                try await networkService.sendUserSettings(data)
                
                // В случае успеха кешируем новые данные
                inMemoryStorage.saveValue(userSettings, for: .userSettings)
                
                updateScreen()
                
                if needToast {
                    toastService.show(.success(Strings.successSaved))
                }
            } catch {
                // В случае проблемы с отправкой, откатываем текущие
                // данные к предыдущему состоянию
                if let savedSettings: UserSettings = inMemoryStorage.getValue(from: .userSettings) {
                    self.userSettings = savedSettings
                    updateScreen()
                }
            }
            
            state.phoneIsLoading = false
            state.emailIsLoading = false
        }
    }
}

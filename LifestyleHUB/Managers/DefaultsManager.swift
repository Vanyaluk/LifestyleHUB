//
//  DefaultsManager.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 22.03.2024.
//

import UIKit

public final class DefaultsManager {
    
    public static let shared = DefaultsManager()
    
    private let userSession: String = "UserSessionData"
    
    private init() { }
    
    /// после проверки по паролю, записываем вошедшую ссесию
    public func addNewSession(with nickname: String) {
        UserDefaults.standard.set(nickname, forKey: userSession)
    }
    
    /// проверяем, есть ли актуальная ссесия
    public func nowSession() -> String? {
        return UserDefaults.standard.string(forKey: userSession)
    }
    
    /// выходим из ссесии
    public func deleteSession() {
        UserDefaults.standard.removeObject(forKey: userSession)
    }
}

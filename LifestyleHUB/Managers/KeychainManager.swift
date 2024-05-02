//
//  UserManager.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 17.03.2024.
//

import UIKit

enum KeychainRegistrationResult {
    case dublicateEntry
    case unknown(String)
    case success
}

enum KeychainLoginResult {
    case noFoundUser
    case incorrectPassword
    case success
    case accountLost
}

protocol KeychainManagerProtocol: AnyObject {
    
    /// создание нового аккаунта
    func create(nickname: String, password: String) -> KeychainRegistrationResult
    
    /// вход с уже существующим аккаунтом, сообщает успешен ли код
    func login(with nickname: String, password: String) -> KeychainLoginResult
}


class KeychainManager: KeychainManagerProtocol {
    
    static let shared = KeychainManager()
    
    private init() {}
    
    func create(nickname: String, password: String) -> KeychainRegistrationResult {
        let formattedPassword = password.data(using: .utf8) ?? Data()
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "LifestyleHUB.com" as AnyObject,
            kSecAttrAccount as String: nickname as AnyObject,
            kSecValueData as String: formattedPassword as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            return .dublicateEntry
        }
        
        guard status == errSecSuccess else {
            return .unknown("Ошибка при сохранении данных")
        }
        
        return .success
    }
    
    func login(with nickname: String, password: String) -> KeychainLoginResult {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "LifestyleHUB.com" as AnyObject,
            kSecAttrAccount as String: nickname as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        
        if let resultData = result as? Data {
            let fetchedPassword = String(decoding: resultData, as: UTF8.self)
            if fetchedPassword == password {
                return .success
            } else {
                return .incorrectPassword
            }
        }
        
        return .noFoundUser
    }
}

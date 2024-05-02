//
//  LoginInteractor.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit

protocol LoginInteractorProtocol: AnyObject {
    func loginUser(with nickname: String, password: String)
}

class LoginInteractor: LoginInteractorProtocol {
    
    weak var presenter: LoginPresenterProtocolOutput?
    
    func loginUser(with nickname: String, password: String) {
        let result = KeychainManager.shared.login(with: nickname, password: password)
        if result == .success {
            if CoreDataManager.shared.fetchUser(nickname: nickname) != nil {
                DefaultsManager.shared.addNewSession(with: nickname)
                presenter?.loginResults(result)
            } else {
                presenter?.loginResults(.accountLost)
            }
        } else {
            presenter?.loginResults(result)
        }
        
    }
}

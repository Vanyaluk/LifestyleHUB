//
//  RegisterPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit

/// от view
protocol RegisterPresenterProtocolInput: AnyObject {
    func viewDidLoaded()
    
    func registerUser(with nickname: String, password: String)
}

/// от интерактора
protocol RegisterPresenterProtocolOutput: AnyObject {
    func registerResults(_ result: KeychainRegistrationResult)
}

class RegisterPresenter {
    weak var view: RegisterViewProtocol?
    var router: RegisterRouterProtocol
    var interactor: RegisterInteractorProtocol
    
    var completion: () -> Void

    init(router: RegisterRouterProtocol, interactor: RegisterInteractorProtocol, completion: @escaping () -> Void) {
        self.router = router
        self.interactor = interactor
        self.completion = completion
    }
}

extension RegisterPresenter: RegisterPresenterProtocolInput {
    func viewDidLoaded() {
        // first setup view
    }
    
    func registerUser(with nickname: String, password: String) {
        // проверка на содержание полей
        if nickname.replacingOccurrences(of: " ", with: "").isEmpty {
            view?.registerResultes(result: .unknown("Введите логин"))
        } else if password.replacingOccurrences(of: " ", with: "").isEmpty {
            view?.registerResultes(result: .unknown("Введите пароль"))
        } else {
            interactor.registerUser(with: nickname, password: password)
        }
    }
}

extension RegisterPresenter: RegisterPresenterProtocolOutput {
    func registerResults(_ result: KeychainRegistrationResult) {
        view?.registerResultes(result: result)
        
        switch result {
        case .success:
            completion()
        default: break
        }
        
        view?.registerResultes(result: result)
    }
}

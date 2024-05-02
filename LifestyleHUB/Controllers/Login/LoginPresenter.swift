//
//  LoginPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit

/// от view
protocol LoginPresenterProtocolInput: AnyObject {
    func viewDidLoaded()
    
    func loginUser(with nickname: String, password: String)
}

/// от интерактора
protocol LoginPresenterProtocolOutput: AnyObject {
    func loginResults(_ result: KeychainLoginResult)
}

class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol
    var interactor: LoginInteractorProtocol
    
    /// completion по окончании действия на view
    var completion: () -> Void

    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol, completion: @escaping () -> Void) {
        self.interactor = interactor
        self.router = router
        self.completion = completion
    }
}

extension LoginPresenter: LoginPresenterProtocolInput {
    func viewDidLoaded() {
        // first setup view
    }
    
    func loginUser(with nickname: String, password: String) {
        interactor.loginUser(with: nickname, password: password)
    }
}

extension LoginPresenter: LoginPresenterProtocolOutput {
    func loginResults(_ result: KeychainLoginResult) {
        view?.loginResultes(result: result)
        
        if result == .success {
            completion()
        }
    }
}

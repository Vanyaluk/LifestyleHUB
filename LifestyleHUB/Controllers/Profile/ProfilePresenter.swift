//
//  ProfilePresenter.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

/// from view
protocol ProfilePresenterInput: AnyObject {
    func viewDidLoaded()
    
    func openLoginController()
    
    func openRegisterController()
    
    func logout()
}

/// from interactor
protocol ProfilePresenterOutput: AnyObject {
    func showSession(user: User?)
}

class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol
    var interactor: ProfileInteractorProtocol
    
    var loginAssembly: LoginAssembly
    var registerAssembly: RegisterAssembly
    
    init(router: ProfileRouterProtocol, interactor: ProfileInteractorProtocol, loginAssembly: LoginAssembly, registerAssembly: RegisterAssembly) {
        self.router = router
        self.interactor = interactor
        self.loginAssembly = loginAssembly
        self.registerAssembly = registerAssembly
    }
    
}

extension ProfilePresenter: ProfilePresenterInput {
    func viewDidLoaded() {
        interactor.loadSession()
    }
    
    func openLoginController() {
        router.showLoginController(loginAssembly: loginAssembly) {
            self.interactor.loadSession()
        }
    }
    
    func openRegisterController() {
        router.showRegisterController(registerAssembly: registerAssembly) {
            self.interactor.loadSession()
        }
    }
    
    func logout() {
        interactor.logoutSession()
    }
}

extension ProfilePresenter: ProfilePresenterOutput {
    func showSession(user: User?) {
        view?.showProfile(user: user)
    }
}

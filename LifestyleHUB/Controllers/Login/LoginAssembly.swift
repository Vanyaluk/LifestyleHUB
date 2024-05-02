//
//  LoginModuleBuilder.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit

class LoginAssembly {
    
    func assemble(completion: @escaping () -> Void) -> LoginViewController {
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter(interactor: interactor, router: router, completion: completion)
        let viewController = LoginViewController()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        
        return viewController
    }
    
}

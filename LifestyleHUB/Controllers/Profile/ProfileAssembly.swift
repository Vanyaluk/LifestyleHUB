//
//  ProfileAssemply.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

final class ProfileAssemply {
    
    let loginAssembly: LoginAssembly
    let registerAssembly: RegisterAssembly
    
    init(loginAssembly: LoginAssembly, registerAssembly: RegisterAssembly) {
        self.loginAssembly = loginAssembly
        self.registerAssembly = registerAssembly
    }
    
    func assemble() -> UIViewController {
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(router: router, interactor: interactor, loginAssembly: loginAssembly, registerAssembly: registerAssembly)
        let viewController = ProfileViewController()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        
        return viewController
    }
}

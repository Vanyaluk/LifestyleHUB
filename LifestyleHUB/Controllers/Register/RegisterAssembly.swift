//
//  RegisterModuleBuilder.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit

class RegisterAssembly {
    
    let randomUserService: RandomUserService
    
    init(randomUserService: RandomUserService) {
        self.randomUserService = randomUserService
    }
    
    func assemble(completion: @escaping () -> Void) -> RegisterViewController {
        let interactor = RegisterInteractor(randomUserService: randomUserService)
        let router = RegisterRouter()
        let presenter = RegisterPresenter(router: router, interactor: interactor, completion: completion)
        let viewController = RegisterViewController()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        
        return viewController
    }
    
}

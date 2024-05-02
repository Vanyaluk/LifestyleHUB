//
//  ProfileRouter.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func showLoginController(loginAssembly: LoginAssembly, completion: @escaping () -> Void)
    
    func showRegisterController(registerAssembly: RegisterAssembly, completion: @escaping () -> Void)
}

class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: ProfileViewController?
    
    func showLoginController(loginAssembly: LoginAssembly, completion: @escaping () -> Void) {
        let vc = loginAssembly.assemble(completion: completion)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .flipHorizontal
        self.viewController?.present(nav, animated: true)
    }
    
    func showRegisterController(registerAssembly: RegisterAssembly, completion: @escaping () -> Void) {
        let vc = registerAssembly.assemble(completion: completion)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .flipHorizontal
        self.viewController?.present(nav, animated: true)
    }
}

//
//  ProfileInteractor.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

protocol ProfileInteractorProtocol: AnyObject {
    func loadSession()
    
    func logoutSession()
}

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterOutput?
    
    func loadSession() {
        guard let nickname = DefaultsManager.shared.nowSession() else {
            presenter?.showSession(user: nil)
            return
        }
        
        if let user = CoreDataManager.shared.fetchUser(nickname: nickname) {
            presenter?.showSession(user: user)
        } else {
            DefaultsManager.shared.deleteSession()
            presenter?.showSession(user: nil)
        }
    }
    
    func logoutSession() {
        DefaultsManager.shared.deleteSession()
        loadSession()
    }
}

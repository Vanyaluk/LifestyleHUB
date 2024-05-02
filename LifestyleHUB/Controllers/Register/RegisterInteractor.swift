//
//  RegisterInteractor.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit



protocol RegisterInteractorProtocol: AnyObject {
    func registerUser(with nickname: String, password: String)
}

class RegisterInteractor: RegisterInteractorProtocol {
    
    weak var presenter: RegisterPresenterProtocolOutput?
    var randomUserService: RandomUserServiceProtocol
    
    init(randomUserService: RandomUserServiceProtocol) {
        self.randomUserService = randomUserService
    }
    
    func registerUser(with nickname: String, password: String) {
        randomUserService.loadUserInfo { result in
            switch result {
            case .success(let data):
                
                do {
                    let user = try JSONDecoder().decode(UserRequestModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.loadImage(nickname: nickname, password: password, request: user)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter?.registerResults(.unknown("Ошибка при декодинге"))
                    }
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.presenter?.registerResults(.unknown("Данные о пользователе не были получены"))
                }
            }
        }
    }
    
    private func loadImage(nickname: String, password: String, request: UserRequestModel) {
        if let temp = request.results.first {
            randomUserService.loadImage(with: temp.picture.large) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let resultReg = KeychainManager.shared.create(nickname: nickname, password: password)
                        
                        switch resultReg {
                        case .dublicateEntry:
                            self.presenter?.registerResults(resultReg)
                        case .unknown(_):
                            self.presenter?.registerResults(resultReg)
                        case .success:
                            CoreDataManager.shared.createUser(nickname: nickname,
                                                              name: "\(temp.name.first) \(temp.name.last)",
                                                              age: Int16(temp.dob.age),
                                                              email: temp.email,
                                                              image: data)
                            DefaultsManager.shared.addNewSession(with: nickname)
                            self.presenter?.registerResults(.success)
                        }
                    }
                case .failure(_):
                    self.presenter?.registerResults(.unknown("Ошибка при загрузке фото"))
                }
            }
        }
    }
}

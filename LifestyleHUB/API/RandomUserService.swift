//
//  UserService.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 22.03.2024.
//

import UIKit

protocol RandomUserServiceProtocol: AnyObject {
    
    /// загрузка данных рандомного пользователя
    func loadUserInfo(completion: @escaping (Result<Data, Error>) -> Void)
    
    /// загрузка изображения пользователя
    func loadImage(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class RandomUserService: RandomUserServiceProtocol {
    
    func loadUserInfo(completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = "https://randomuser.me/api/"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 8
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
              if let error = error {
                  completion(.failure(error))
              } else {
                  if let data = data {
                      completion(.success(data))
                  }
              }
            }).resume()
        }
    }
    
    func loadImage(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
              if let error = error {
                  completion(.failure(error))
              } else {
                  if let data = data {
                      completion(.success(data))
                  }
              }
            }).resume()
        }
    }
    
}

//
//  WeatherService.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

protocol WeatherServiceProtocol: AnyObject {
    
    /// Получение данных о погоде
    func getWeather(ll: (Double, Double), completion: @escaping (Result<Data, Error>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    
    private let API_KEY = "3d93e17ef09128f1b6f9d1e72cd97d37"
    
    func getWeather(ll: (Double, Double), completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(ll.0)&lon=\(ll.1)&appid=\(API_KEY)&lang=ru"
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
            request.timeoutInterval = 5.0
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let dataE = data {
                        completion(.success(dataE))
                    }
                }
            }.resume()
        }
    }
}

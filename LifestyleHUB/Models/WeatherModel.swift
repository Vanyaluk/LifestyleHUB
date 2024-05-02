//
//  File.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let feels_like, temp_min, temp_max, temp: Float
}

// MARK: - Weather
struct Weather: Codable {
    let icon, description: String
}

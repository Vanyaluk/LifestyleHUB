//
//  RootPresenter.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

enum WeatherData {
    case dataError
    case weatherInfo(temperature: String, firstText: String, feelsLike: String, status: String, image: UIImage?)
}

// данные от view
protocol RootPresenterProtocolInput: AnyObject {
    func viewDidLoaded()
    
    func loadingVenues(offset: Int)
    
    func pushVenueDetails(with venue: VenueModel)
}

// данные от interactor
protocol RootPresenterProtocolOutput: AnyObject {
    func updateWeather(with model: WeatherModel?)
    
    func updateVenues(with models: [VenueModel])
    
    func updateImage(with data: Data?, of id: String)
    
    /// получение геолокации
    func acceptLocation()
}

class RootPresenter {
    
    weak var view: RootViewProtocol?
    var router: RootRouterProtocol
    var interactor: RootInteractorProtocol
    
    var venueAssebmle: VenueAssembly
    
    init(router: RootRouterProtocol, interactor: RootInteractorProtocol, venueAssebmle: VenueAssembly) {
        self.router = router
        self.interactor = interactor
        self.venueAssebmle = venueAssebmle
    }
}

extension RootPresenter: RootPresenterProtocolInput {
    func viewDidLoaded() {
        interactor.loadVenues(offset: 0)
        interactor.loadWeather()
    }
    
    func loadingVenues(offset: Int) {
        interactor.loadVenues(offset: offset)
    }
    
    func pushVenueDetails(with venue: VenueModel) {
        if let id = venue.venue?.id {
            router.openVenueCard(with: id, assembly: venueAssebmle)
        }
    }
}


extension RootPresenter: RootPresenterProtocolOutput {
    func updateWeather(with model: WeatherModel?) {
        if let weatherInfo = model {
            let temp = "\(Int(weatherInfo.main.temp - 273.15))°"
            let first = "\(weatherInfo.name): от \(Int(weatherInfo.main.temp_min - 273.15))° до \(Int(weatherInfo.main.temp_max - 273.15))°"
            
            let feelsLike = "ощущается как \(Int(weatherInfo.main.feels_like - 273.15))°"
            
            let status = weatherInfo.weather.first?.description ?? "no data"
            
            let image = UIImage(named: "\(weatherInfo.weather.first?.icon ?? "01d")")
            
            
            self.view?.showWeather(content: .weatherInfo(temperature: temp, firstText: first, feelsLike: feelsLike, status: status, image: image))
        } else {
            self.view?.showWeather(content: .dataError)
        }
    }
    
    func updateVenues(with models: [VenueModel]) {
        view?.showVenues(content: models)
    }
    
    func updateImage(with data: Data?, of id: String) {
        view?.showVenueImage(with: data, of: id)
    }
    
    func acceptLocation() {
        view?.ifNeedReload()
    }
}

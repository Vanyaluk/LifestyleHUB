//
//  RootInteractor.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

protocol RootInteractorProtocol: AnyObject {
    func loadWeather()
    
    func loadVenues(offset: Int)
}

class RootInteractor: RootInteractorProtocol {
    
    weak var presenter: RootPresenterProtocolOutput?
    
    private let weatherService: WeatherServiceProtocol
    private let locationManager: LocationManager
    let venueService: VenueServiceProtocol
    
    private var location: (Double, Double)?
    
    init(weatherService: WeatherServiceProtocol, locationManager: LocationManager, venueService: VenueService) {
        self.weatherService = weatherService
        self.locationManager = locationManager
        self.venueService = venueService
        
        locationManager.getCurrentLocation { lat, lon in
            self.location = (lat, lon)
            self.presenter?.acceptLocation()
        }
    }
    
    func loadWeather() {
        if let location = location {
            self.weatherService.getWeather(ll: location) { result in
                switch result {
                case .success(let data):
                    do {
                        let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                        DispatchQueue.main.async { self.presenter?.updateWeather(with: weatherModel) }
                    } catch {
                        DispatchQueue.main.async { self.presenter?.updateWeather(with: nil) }
                    }
                case .failure(_):
                    DispatchQueue.main.async { self.presenter?.updateWeather(with: nil) }
                }
            }
        } else {
            DispatchQueue.main.async { self.presenter?.updateWeather(with: nil) }
        }
    }
    
    // загрузка при первом включении
    func loadVenues(offset: Int) {
        if offset == 0 {
            venueService.cancelAllTasks()
        }
        
        if let location = location {
            self.venueService.loadVenues(ll: location, offset: offset) { result in
                switch result {
                case .success(let jsonData):
                    do {
                        let venuesModel = try JSONDecoder().decode(VenuesModel.self, from: jsonData)
                        if let venues = venuesModel.response?.group?.results {
                            
                            DispatchQueue.main.async {
                                self.presenter?.updateVenues(with: venues)
                                self.loadImages(for: venues)
                            }
                            
                        } else {
                            DispatchQueue.main.async { self.presenter?.updateVenues(with: []) }
                        }
                    } catch {
                        DispatchQueue.main.async { self.presenter?.updateVenues(with: []) }
                    }
                case .failure(_):
                    DispatchQueue.main.async { self.presenter?.updateVenues(with: []) }
                }
            }
        } else {
            self.presenter?.updateVenues(with: [])
        }
    }
    
    private func loadImages(for venues: [VenueModel]) {
        venues.indices.forEach { index in
            if let prefix = venues[index].photo?.prefix, let suffix = venues[index].photo?.suffix {
                if prefix.count > 0 && suffix.count > 0 {
                    venueService.loadImage(hightPrioriry: false, prefix: prefix, suffix: suffix) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                self.presenter?.updateImage(with: data, of: venues[index].id ?? "")
                            case .failure(_):
                                self.presenter?.updateImage(with: nil, of: venues[index].id ?? "")
                            }
                        }
                    }
                } else {
                    self.presenter?.updateImage(with: nil, of: venues[index].id ?? "")
                }
            } else {
                self.presenter?.updateImage(with: nil, of: venues[index].id ?? "")
            }
        }
    }
    
}

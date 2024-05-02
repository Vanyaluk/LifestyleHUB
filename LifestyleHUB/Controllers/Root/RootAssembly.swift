//
//  RootAssembly.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

final class RootAssembly {
    
    var weatherService: WeatherService
    var locationManager: LocationManager
    var venueService: VenueService
    
    var newEventAssembly: NewEventAssembly
    var venueAssembly: VenueAssembly
    
    init(weatherService: WeatherService, locationManager: LocationManager, venueService: VenueService, newEventAssembly: NewEventAssembly, venueAssembly: VenueAssembly) {
        self.weatherService = weatherService
        self.locationManager = locationManager
        self.venueService = venueService
        self.newEventAssembly = newEventAssembly
        self.venueAssembly = venueAssembly
    }
    
    func assemble() -> UIViewController {
        let interactor = RootInteractor(weatherService: weatherService, locationManager: locationManager, venueService: venueService)
        let router = RootRouter()
        let presenter = RootPresenter(router: router, interactor: interactor, venueAssebmle: venueAssembly)
        let viewController = RootViewController()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        
        return viewController
    }
}

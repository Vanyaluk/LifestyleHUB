//
//  VenueAssembly.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 20.03.2024.
//

import UIKit

final class VenueAssembly {
    
    var venueService: VenueServiceProtocol
    var newEventAssembly: NewEventAssembly
    
    init(venueService: VenueServiceProtocol, newEventAssembly: NewEventAssembly) {
        self.venueService = venueService
        self.newEventAssembly = newEventAssembly
    }
    
    func assemble(with venueId: String) -> UIViewController {
        let interactor = VenueInteractor(venueService: venueService)
        let router = VenueRouter()
        let presenter = VenuePresenter(router: router, interactor: interactor, newEventAssembly: newEventAssembly)
        let viewController = VenueViewController()
        
        viewController.venueId = venueId
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        
        return viewController
    }
}


//
//  EventsModuleBuilder.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

class EventsAssembly {
    
    var newEventAssembly: NewEventAssembly
    var venueAssembly: VenueAssembly
    var notificationManager: NotificationManager
    
    init(newEventAssembly: NewEventAssembly, venueAssembly: VenueAssembly, notificationManager: NotificationManager) {
        self.newEventAssembly = newEventAssembly
        self.venueAssembly = venueAssembly
        self.notificationManager = notificationManager
    }
    
    func assemble() -> EventsViewController {
        let interactor = EventsInteractor(notificationManager: notificationManager)
        let router = EventsRouter()
        let presenter = EventsPresenter(router: router, interactor: interactor, venueAssembly: venueAssembly, newEventAssembly: newEventAssembly)
        let viewController = EventsViewController()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        
        return viewController
    }
    
}

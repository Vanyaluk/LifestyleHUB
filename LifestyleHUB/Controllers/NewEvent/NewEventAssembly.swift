//
//  NewEventModuleBuilder.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

class NewEventAssembly {
    
    var notificationManager: NotificationManager
    
    init(notificationManager: NotificationManager) {
        self.notificationManager = notificationManager
    }
    
    func assemble(venueId: String? = nil, venueName: String? = nil, completion: @escaping () -> Void) -> NewEventViewController {
        let interactor = NewEventInteractor(notificationManager: notificationManager)
        let router = NewEventRouter()
        let presenter = NewEventPresenter(interactor: interactor, router: router, completion: completion)
        let viewController = NewEventViewController()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        
        viewController.venueId = venueId
        viewController.venueName = venueName
        
        return viewController
    }
    
}

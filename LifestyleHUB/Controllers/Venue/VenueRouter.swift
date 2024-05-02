//
//  VenueRouter.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 20.03.2024.
//


import UIKit

protocol VenueRouterProtocol: AnyObject {
    func presentEventController(newEventAssembly: NewEventAssembly, with id: String, title: String)
}

class VenueRouter: VenueRouterProtocol {
    weak var viewController: VenueViewController?
    
    func presentEventController(newEventAssembly: NewEventAssembly, with id: String, title: String) {
        let vc = newEventAssembly.assemble(venueId: id, venueName: title) {}
        let nav = UINavigationController(rootViewController: vc)
        viewController?.present(nav, animated: true)
    }
}

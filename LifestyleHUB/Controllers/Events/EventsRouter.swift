//
//  EventsRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

protocol EventsRouterProtocol {
    func presentNewEventView(newEventAssembly: NewEventAssembly, completion: @escaping () -> Void)
    
    func showEventVenue(id: String, assembly: VenueAssembly)
    
    func showAlertNoVenue()
}

class EventsRouter: EventsRouterProtocol {
    
    weak var viewController: EventsViewController?
    
    func presentNewEventView(newEventAssembly: NewEventAssembly, completion: @escaping () -> Void) {
        let vc = newEventAssembly.assemble(completion: completion)
        let nav = UINavigationController(rootViewController: vc)
        viewController?.present(nav, animated: true)
    }
    
    func showEventVenue(id: String, assembly: VenueAssembly) {
        let viewController = assembly.assemble(with: id)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAlertNoVenue() {
        let alertController = UIAlertController(title: "Место не привязано", message: "Данное событие было создано без привязки к месту.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default)
        alertController.addAction(okAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}

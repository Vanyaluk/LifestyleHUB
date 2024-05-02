//
//  EventsPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

/// от view
protocol EventsPresenterProtocolInput: AnyObject {
    func viewDidLoaded()
    
    func openNewEventView()
    
    func cellTapped(id: String?)
    
    func removeCellTapped(id: UUID)
}

/// от интерактора
protocol EventsPresenterProtocolOutput: AnyObject {
    func showEvents(_ events: [Event])
}

class EventsPresenter {
    weak var view: EventsViewProtocol?
    var router: EventsRouterProtocol
    var interactor: EventsInteractorProtocol
    
    var venueAssembly: VenueAssembly
    var newEventAssembly: NewEventAssembly

    init(router: EventsRouterProtocol, interactor: EventsInteractorProtocol, venueAssembly: VenueAssembly, newEventAssembly: NewEventAssembly) {
        self.router = router
        self.interactor = interactor
        self.venueAssembly = venueAssembly
        self.newEventAssembly = newEventAssembly
    }
}

extension EventsPresenter: EventsPresenterProtocolInput {
    func viewDidLoaded() {
        interactor.fetchEvents()
    }
    
    func openNewEventView() {
        router.presentNewEventView(newEventAssembly: newEventAssembly) {
            self.interactor.fetchEvents()
        }
    }
    
    func cellTapped(id: String?) {
        if let id = id {
            router.showEventVenue(id: id, assembly: venueAssembly)
        } else {
            router.showAlertNoVenue()
        }
    }
    
    func removeCellTapped(id: UUID) {
        interactor.removeCell(id: id)
    }
}

extension EventsPresenter: EventsPresenterProtocolOutput {
    func showEvents(_ events: [Event]) {
        view?.showEvents(fetchedEvents: events)
    }
}

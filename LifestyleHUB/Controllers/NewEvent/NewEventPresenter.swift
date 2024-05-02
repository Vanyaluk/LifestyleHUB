//
//  NewEventPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

/// от view
protocol NewEventPresenterProtocolInput {
    func viewDidLoaded()
    
    func saveEvent(title: String, notes: String, date: Date, venueId: String?, venueName: String?, isOn: Bool)
}

/// от интерактора
protocol NewEventPresenterProtocolOutput: AnyObject {
    
}

class NewEventPresenter {
    weak var view: NewEventViewProtocol?
    var router: NewEventRouterProtocol
    var interactor: NewEventInteractorProtocol
    
    var completion: () -> Void

    init(interactor: NewEventInteractorProtocol, router: NewEventRouterProtocol, completion: @escaping () -> Void) {
        self.interactor = interactor
        self.router = router
        self.completion = completion
    }
}

extension NewEventPresenter: NewEventPresenterProtocolInput {
    func viewDidLoaded() {
        // first setup view
    }
    
    func saveEvent(title: String, notes: String, date: Date, venueId: String?, venueName: String?, isOn: Bool) {
        if date > Date.now.addingTimeInterval(910) {
            interactor.saveEvent(title: title, notes: notes, date: date, venueId: venueId, venueName: venueName, isOn: isOn)
            completion()
            router.dismissView()
        }
    }
}

extension NewEventPresenter: NewEventPresenterProtocolOutput {
}

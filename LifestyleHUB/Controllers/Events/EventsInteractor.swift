//
//  EventsInteractor.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

protocol EventsInteractorProtocol: AnyObject {
    func fetchEvents()
    
    func removeCell(id: UUID)
}

class EventsInteractor: EventsInteractorProtocol {
    
    weak var presenter: EventsPresenterProtocolOutput?
    var notificationManager: NotificationManager
    
    init(notificationManager: NotificationManager) {
        self.notificationManager = notificationManager
    }
    
    func fetchEvents() {
        let events = CoreDataManager.shared.fetchEvents()
        presenter?.showEvents(events)
    }
    
    func removeCell(id: UUID) {
        CoreDataManager.shared.deleteEvent(with: id)
        notificationManager.deleteNotification(with: id)
    }
}

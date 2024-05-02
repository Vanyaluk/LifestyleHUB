//
//  NewEventInteractor.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

protocol NewEventInteractorProtocol: AnyObject {
    func saveEvent(title: String, notes: String, date: Date, venueId: String?, venueName: String?, isOn: Bool)
}

class NewEventInteractor: NewEventInteractorProtocol {
    weak var presenter: NewEventPresenterProtocolOutput?
    
    var notificationManager: NotificationManager
    
    init(notificationManager: NotificationManager) {
        self.notificationManager = notificationManager
    }
    
    func saveEvent(title: String, notes: String, date: Date, venueId: String?, venueName: String?, isOn: Bool) {
        let id = UUID()
        CoreDataManager.shared.createEvent(id: id, venueId: venueId, venueName: venueName, date: date, title: title, notes: notes)
        if isOn {
            notificationManager.createNewNotification(with: id, title: title, date: date.addingTimeInterval(-900))
        }
        
    }
}

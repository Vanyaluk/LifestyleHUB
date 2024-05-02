//
//  CoreDataManager.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 22.03.2024.
//

import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    
    public static let shared = CoreDataManager()
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    /// Создаем пользователя
    public func createUser(nickname: String, name: String, age: Int16, email: String, image: Data) {
        guard let userEntityDescription = NSEntityDescription.entity(forEntityName: "User", in: context) else { return }
        
        let user = User(entity: userEntityDescription, insertInto: context)
        user.nickname = nickname
        user.name = name
        user.age = age
        user.image = image
        user.email = email
        
        appDelegate.saveContext()
    }
    
    /// Подгружаем данные пользователя
    public func fetchUser(nickname: String) -> User? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let users = try? context.fetch(fetchRequest) as? [User]
            return users?.first(where: { $0.nickname == nickname })
        }
    }
    
    /// создаем новое событие
    public func createEvent(id: UUID, venueId: String? = nil, venueName: String? = nil, date: Date, title: String, notes: String) {
        guard let userEntityDescription = NSEntityDescription.entity(forEntityName: "Event", in: context) else { return }
        
        let event = Event(entity: userEntityDescription, insertInto: context)
        event.id = id
        event.venueId = venueId
        event.venueName = venueName
        event.date = date
        event.title = title
        event.notes = notes
        
        appDelegate.saveContext()
    }
    
    /// подгружаем все события
    public func fetchEvents() -> [Event] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            let events = (try? context.fetch(fetchRequest) as? [Event]) ?? []
            return events.reversed()
        }
    }
    
    /// подгружаем определенное событие
    public func fetchEvent(with id: UUID) -> Event? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            guard let events = try? context.fetch(fetchRequest) as? [Event] else { return nil }
            return events.first(where: { $0.id == id})
        }
    }
    
    /// изменяем определенное событие
    public func updateEvent(with id: UUID, title: String? = nil, notes: String? = nil, date: Date? = nil) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            guard let events = try? context.fetch(fetchRequest) as? [Event], let event = events.first(where: { $0.id == id}) else { return }
            
            if let title = title {
                event.title = title
            }
            
            if let notes = notes {
                event.notes = notes
            }
            
            if let date = date {
                event.date = date
            }
        }
        
        appDelegate.saveContext()
    }
    
    /// удаляем определенное событие
    public func deleteEvent(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            guard let events = try? context.fetch(fetchRequest) as? [Event],
                    let event = events.first(where: { $0.id == id}) else { return }
            
            context.delete(event)
        }
        appDelegate.saveContext()
    }
}

//
//  Event+CoreDataProperties.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 23.03.2024.
//
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {}


extension Event {

    @NSManaged public var id: UUID?
    @NSManaged public var venueId: String?
    @NSManaged public var venueName: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var notes: String?

}

extension Event : Identifiable {}

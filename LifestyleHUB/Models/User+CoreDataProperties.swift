//
//  User+CoreDataProperties.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 22.03.2024.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {}


extension User {

    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var email: String?
    @NSManaged public var image: Data?
    
}

extension User : Identifiable {}

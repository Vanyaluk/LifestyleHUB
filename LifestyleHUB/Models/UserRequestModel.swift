//
//  UserRequestModel.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 22.03.2024.
//

import Foundation

struct UserRequestModel: Codable {
    let results: [UserRequestResults]
    
    struct UserRequestResults: Codable {
        let name: UserRequestName
        let email: String
        let dob: UserRequestDob
        let picture: UserRequestPicture
        
        struct UserRequestName: Codable {
            let first: String
            let last: String
        }
        
        struct UserRequestDob: Codable {
            let age: Int
        }
        
        struct UserRequestPicture: Codable {
            let large: String
        }
    }
}

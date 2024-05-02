// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let venueModel = try? JSONDecoder().decode(VenueModel.self, from: jsonData)

import UIKit

// MARK: - Welcome
struct VenuesModel: Codable {
    let response: Response?
    let meta: MetaData?
}

// MARK: - MetaData
struct MetaData: Codable {
    let requestId: String?
    let code: Int?
}
 
// MARK: - Response
struct Response: Codable {
    let group: ResponseGroup?
}
 
// MARK: - ResponseGroup
struct ResponseGroup: Codable {
    let results: [VenueModel]?
    let totalResults: Int?
}
 
// MARK: - VenueModel Main
struct VenueModel: Codable {
    let displayType: String?
    let venue: Venue?
    let id: String?
    let photo: PhotoElement?
    let photos: Photos?
    let snippets: Snippets?
    var imageData: Data?
    var imagesData: [Data]?
}
 
 
// MARK: - PhotoElement
struct PhotoElement: Codable {
    let id: String?
    let createdAt: Int?
    let prefix: String?
    let suffix: String?
    let width, height: Int?
    let visibility: Visibility?
    let user: EUser?
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt
        case prefix = "prefix"
        case suffix, width, height, visibility, user
    }
}
 
// MARK: - User
struct EUser: Codable {
    let id, firstName, lastName, handle: String?
    let privateProfile: Bool?
    let gender: FollowingRelationship?
    let address, city, state, countryCode: String?
    let followingRelationship: FollowingRelationship?
    let photo: UserPhoto?
}
 
enum FollowingRelationship: String, Codable {
    case female = "female"
    case male = "male"
    case none = "none"
}
 
// MARK: - UserPhoto
struct UserPhoto: Codable {
    let prefix: String?
    let suffix: String?
    let photoDefault: Bool?
    
    enum CodingKeys: String, CodingKey {
        case prefix = "prefix"
        case suffix
        case photoDefault = "default"
    }
}
 
enum Visibility: String, Codable {
    case visibilityPublic = "public"
}
 
// MARK: - Photos
struct Photos: Codable {
    let count: Int?
    let groups: [GroupElement]?
}
 
// MARK: - GroupElement
struct GroupElement: Codable {
    let type: String?
    let name: String?
    let count: Int?
    let items: [PhotoElement]?
}

 
// MARK: - Snippets
struct Snippets: Codable {
    let count: Int?
    let items: [SnippetsItem]?
}
 
// MARK: - SnippetsItem
struct SnippetsItem: Codable {
    let detail: Detail?
}
 
// MARK: - Detail
struct Detail: Codable {
    let type: DetailType?
    let object: EObject?
}
 
// MARK: - Object
struct EObject: Codable {
    let id: String?
    let createdAt: Int?
    let text: String?
    let type: ObjectType?
    let canonicalURL: String?
    let logView: Bool?
    let agreeCount, disagreeCount: Int?
    let todo: Todo?
    let user: EUser?
    let socialStatusBar: SocialStatusBar?
    let lastVoteText: String?
    let lastUpvoteTimestamp: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt, text, type
        case canonicalURL = "canonicalUrl"
        case logView, agreeCount, disagreeCount, todo, user, socialStatusBar, lastVoteText, lastUpvoteTimestamp
    }
}
 
// MARK: - SocialStatusBar
struct SocialStatusBar: Codable {
    let items: [SocialStatusBarItem]?
}
 
// MARK: - SocialStatusBarItem
struct SocialStatusBarItem: Codable {
    let type: String?
    let topRated: Bool?
}
 
// MARK: - Todo
struct Todo: Codable {
    let count: Int?
}
 
enum ObjectType: String, Codable {
    case user = "user"
}
 
enum DetailType: String, Codable {
    case socialStatusBar = "socialStatusBar"
    case tip = "tip"
}
 
// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
    let like, dislike, ok: Bool?
    let createdAt: Int?
    let venuePage: VenuePage?
}
 
// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String?
    let icon: Icon?
    let categoryCode: Int?
    let mapIcon: String?
    let primary: Bool?
}
 
// MARK: - Icon
struct Icon: Codable {
    let prefix: String?
    let suffix: Suffix?
 
    enum CodingKeys: String, CodingKey {
        case prefix = "prefix"
        case suffix
    }
}
 
enum Suffix: String, Codable {
    case png = ".png"
}
 
// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode: String?
    let cc: String?
    let neighborhood: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
}

 
// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: Label?
    let lat, lng: Double?
}
 
enum Label: String, Codable {
    case display = "display"
    case entrance = "entrance"
}

 
// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String?
}


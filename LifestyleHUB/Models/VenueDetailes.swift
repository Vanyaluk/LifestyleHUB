//
//  VenueDetailes.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 21.03.2024.
//

import Foundation

// MARK: - VenueDetailes
struct VenueDetailesResponse: Codable {
    let meta: Meta
    let response: IResponse
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?
}

// MARK: - Notification
struct Notification: Codable {
    let type: String?
    let item: NotificationItem
}

// MARK: - NotificationItem
struct NotificationItem: Codable {
    let unreadCount: Int?
}

// MARK: - IResponse
struct IResponse: Codable {
    let venue: VenueDetailes?
}

// MARK: - Venue
struct VenueDetailes: Codable {
    let id, name: String
    let contact: Contact?
    let location: OLocation?
    let canonicalURL: String?
    let categories: [OCategory]?
    let stats: Stats?
    let url: String?
    let likes: HereNow?
    let like, dislike, ok, allowMenuURLEdit: Bool?
    let reasons: Inbox?
    let createdAt: Int?
    let hereNow: HereNow?
    let shortURL: String?
    let timeZone: String?
    let listed: Listed?
    let phrases: [Phrase]?
    let hours: Hours?
    let defaultHours: Hours?
    let pageUpdates: PageUpdates?
    let inbox: Inbox?
    let attributes: Attributes?
    let bestPhoto: BestPhotoClass?
    let photos: PhotosListed?
    let description: String?

}

struct PhotosListed: Codable {
    let count: Int
    let groups: [GroupPhotos]
}

struct GroupPhotos: Codable {
    let count: Int
    let name: String?
    let items: [OItemsPhoto]?
}

struct OItemsPhoto: Codable {
    let prefix: String
    let suffix: String
}

struct GroupItemPhoto: Codable {
    let prefix: String?
    let suffix: String?
}

// MARK: - Attributes
struct Attributes: Codable {
    let groups: [AttributesGroup]
}

// MARK: - AttributesGroup
struct AttributesGroup: Codable {
    let type, name, summary: String?
    let count: Int?
    let items: [PurpleItem]
}

// MARK: - PurpleItem
struct PurpleItem: Codable {
    let displayName, displayValue: String?
}

// MARK: - BestPhotoClass
struct BestPhotoClass: Codable {
    let id: String?
    let createdAt: Int?
    let source: Source?
    let prefix: String?
    let suffix: String?
    let width, height: Int?
    let visibility: String?
    let user: BestPhotoUser?
}

// MARK: - Source
struct Source: Codable {
    let name: String?
    let url: String?
}

// MARK: - BestPhotoUser
struct BestPhotoUser: Codable {
    let id, firstName, lastName, handle: String?
    let privateProfile: Bool?
    let gender, countryCode, followingRelationship: String?
    let photo: IconClass?
}

// MARK: - IconClass
struct IconClass: Codable {
    let photoPrefix: String?
    let suffix: String?
}

// MARK: - Category
struct OCategory: Codable {
    let id, name, pluralName, shortName: String?
    let icon: IconClass?
    let categoryCode: Int?
    let mapIcon: String?
    let primary: Bool?
}

// MARK: - Contact
struct Contact: Codable {
    let phone, formattedPhone, twitter: String?
}

// MARK: - Hours
struct Hours: Codable {
    let status: String?
    let richStatus: RichStatus?
    let isOpen, isLocalHoliday: Bool?
    let timeframes: [Timeframe]
}

// MARK: - RichStatus
struct RichStatus: Codable {
    let entities: [Entity]
    let text: String?
}

// MARK: - Entity
struct Entity: Codable {
    let indices: [Int]
    let type: String?
}

// MARK: - Timeframe
struct Timeframe: Codable {
    let days: String?
    let includesToday: Bool?
    let open: [Open]
}

// MARK: - Open
struct Open: Codable {
    let renderedTime: String?
}

// MARK: - HereNow
struct HereNow: Codable {
    let count: Int?
    let summary: String?
    let groups: [HereNowGroup]
}

// MARK: - HereNowGroup
struct HereNowGroup: Codable {
    let type: String?
    let count: Int?
    let items: [FluffyItem]
    let name: String?
}

// MARK: - FluffyItem
struct FluffyItem: Codable {
    let id, name, description, type: String?
    let user: ItemUser?
    let editable, itemPublic, collaborative: Bool?
    let url: String?
    let canonicalURL: String?
    let createdAt, updatedAt: Int?
    let photo: BestPhotoClass?
    let followers: PageUpdates?
    let listItems: Inbox?
}

// MARK: - PageUpdates
struct PageUpdates: Codable {
    let count: Int?
}

// MARK: - Inbox
struct Inbox: Codable {
    let count: Int?
    let items: [InboxItem]
}

// MARK: - InboxItem
struct InboxItem: Codable {
    let id: String?
    let createdAt: Int?
}

// MARK: - ItemUser
struct ItemUser: Codable {
    let id, firstName, lastName, handle: String?
    let privateProfile: Bool?
    let gender, countryCode, followingRelationship: String?
    let photo: PurplePhoto?
}

// MARK: - PurplePhoto
struct PurplePhoto: Codable {
    let photoPrefix: String?
    let suffix: String?
    let photoDefault: Bool?
}

// MARK: - Listed
struct Listed: Codable {
    let count: Int?
    let groups: [HereNowGroup]
}

// MARK: - OLocation
struct OLocation: Codable {
    let address: String?
    let lat, lng: Double?
    let labeledLatLngs: [OLabeledLatLng]
    let radius50, radius90: Int?
    let cc, city, state, country: String?
    let formattedAddress: [String]
}

// MARK: - OLabeledLatLng
struct OLabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}

// MARK: - Phrase
struct Phrase: Codable {
    let phrase: String?
    let sample: RichStatus?
    let count: Int?
}

// MARK: - Stats
struct Stats: Codable {
    let tipCount: Int?
}

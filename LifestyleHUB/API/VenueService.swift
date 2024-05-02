//
//  VenueService.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 17.03.2024.
//

import UIKit

protocol VenueServiceProtocol: AnyObject {
    /// загрузка событий из API в главную ленту
    func loadVenues(ll: (Double, Double), offset: Int, completion: @escaping (Result<Data, Error>) -> Void)
    
    /// загрузка картинки из API
    func loadImage(hightPrioriry: Bool, prefix: String, suffix: String, completion: @escaping (Result<Data, Error>) -> Void)
    
    /// отмена всех запросов
    func cancelAllTasks()
    
    /// загрузка VenueDetailes из API
    func loadVenue(with id: String, completion: @escaping (Result<Data, Error>) -> Void)
    
    /// сохранение VenueDetailes в кэш
    func save(venue: VenueDetailes)
    
    /// загрузка VenueDetailes из кэша
    func fetchVenue(with id: String) -> VenueDetailes?
    
    /// сохранение bestImage в кэш
    func save(bestImage: Data, id: String)
    
    /// загрузка bestImage из кэша
    func fetchBestImage(with id: String) -> Data?
    
    /// созранение фоток в кэш
    func save(images: [Data], id: String)
    
    /// загрузка фоток из кэша
    func fetchImages(with id: String) -> [Data]
}

class VenueService: VenueServiceProtocol {
    
    struct ImagesVenueCash {
        let id: String
        var bestImageData: Data?
        var imagesData: [Data]
    }
    
    private let TOKEN = "UHIEBVLS4SOIE5VWIJX50UEY5W1YZLRXBB0VNCHIIV0DMXDZ"
    
    private var venueCash = [VenueDetailes]()
    private var imagesVenueCash = [ImagesVenueCash]()
    
    init() {
        
    }
    
    private let session = URLSession.shared
    
    func loadVenues(ll: (Double, Double), offset: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        let stringURL = "https://api.foursquare.com/v2/search/recommendations?limit=10&offset=\(offset)&v=20231010&ll=\(ll.0)%2C\(ll.1)&oauth_token=\(TOKEN)"
        if let url = URL(string: stringURL) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 10.0
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let data = data { completion(.success(data)) }
                }
            }.resume()
        }
    }
    
    func loadImage(hightPrioriry: Bool = false, prefix: String, suffix: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = prefix + "original" + suffix
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
              if let error = error {
                  completion(.failure(error))
              } else {
                  if let data = data {
                      completion(.success(data))
                  }
              }
            })
            if hightPrioriry {
                task.priority = 1
            }
            task.resume()
        }
    }
    
    func loadVenue(with id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let stringURL = "https://api.foursquare.com/v2/venues/\(id)/?v=20231010&oauth_token=\(TOKEN)"
        if let url = URL(string: stringURL) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 10.0
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let data = data { completion(.success(data)) }
                }
            }.resume()
        }
    }
    
    func cancelAllTasks() {
        session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
    
    func save(venue: VenueDetailes) {
        if !venueCash.contains(where: { $0.id == venue.id }) {
            venueCash.append(venue)
        }
    }
    
    func fetchVenue(with id: String) -> VenueDetailes? {
        if let index = venueCash.firstIndex(where: { $0.id == id }) {
            return venueCash[index]
        }
        return nil
    }
    
    func save(bestImage: Data, id: String) {
        if let index = imagesVenueCash.firstIndex(where: { $0.id == id }) {
            if imagesVenueCash[index].bestImageData == nil {
                imagesVenueCash[index].bestImageData = bestImage
            }
        } else {
            imagesVenueCash.append(ImagesVenueCash(id: id, bestImageData: bestImage, imagesData: []))
        }
    }
    
    func fetchBestImage(with id: String) -> Data? {
        if let index = imagesVenueCash.firstIndex(where: { $0.id == id }) {
            return imagesVenueCash[index].bestImageData
        }
        return nil
    }
    
    func save(images: [Data], id: String) {
        if let index = imagesVenueCash.firstIndex(where: { $0.id == id }) {
            imagesVenueCash[index].imagesData.append(contentsOf: images)
        } else {
            imagesVenueCash.append(ImagesVenueCash(id: id, imagesData: images))
        }
    }
    
    func fetchImages(with id: String) -> [Data] {
        if let index = imagesVenueCash.firstIndex(where: { $0.id == id }) {
            return imagesVenueCash[index].imagesData
        }
        return []
    }
    
}

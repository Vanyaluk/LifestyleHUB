//
//  VenueInteractor.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 20.03.2024.
//

import UIKit

protocol VenueInteractorProtocol: AnyObject {
    func loadVenueDetailes(with id: String)
}

class VenueInteractor: VenueInteractorProtocol {
    weak var presenter: VenuePresenterProtocolOutput?
    
    private let venueService: VenueServiceProtocol
    
    init(venueService: VenueServiceProtocol) {
        self.venueService = venueService
    }
    
    func loadVenueDetailes(with id: String) {
        if let venue = venueService.fetchVenue(with: id) {
            presenter?.updateView(with: venue)
            loadMainImage(venue: venue)
            loadImages(venue: venue)
            return
        }
        
        venueService.loadVenue(with: id) { result in
            switch result {
            case .success(let jsonData):
                do {
                    let venueResponse = try JSONDecoder().decode(VenueDetailesResponse.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.presenter?.updateView(with: venueResponse.response.venue)
                        self.loadMainImage(venue: venueResponse.response.venue)
                        self.loadImages(venue: venueResponse.response.venue)
                        if let venue = venueResponse.response.venue {
                            self.venueService.save(venue: venue)
                        }
                    }
                } catch {
                    DispatchQueue.main.async { self.presenter?.updateView(with: nil) }
                }
            case .failure(_):
                DispatchQueue.main.async { self.presenter?.updateView(with: nil) }
            }
        }
    }
    
    private func loadMainImage(venue: VenueDetailes?) {
        if let data = venueService.fetchBestImage(with: venue?.id ?? "") {
            presenter?.setMainImage(with: data)
            return
        }
        if let prefix = venue?.bestPhoto?.prefix, let suffix = venue?.bestPhoto?.suffix {
            if prefix.count > 0 && suffix.count > 0 {
                venueService.loadImage(hightPrioriry: true, prefix: prefix, suffix: suffix) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            self.presenter?.setMainImage(with: data)
                            if let id = venue?.id {
                                self.venueService.save(bestImage: data, id: id)
                            }
                        case .failure(_): break
                        }
                    }
                }
            }
        }
    }
    
    private func loadImages(venue: VenueDetailes?) {
        let imagesData = venueService.fetchImages(with: venue?.id ?? "")
        if !imagesData.isEmpty {
            presenter?.addImages(of: imagesData)
            return
        }
        
        if let photos = venue?.photos?.groups.first?.items {
            photos.prefix(10).forEach { photo in
                venueService.loadImage(hightPrioriry: true, prefix: photo.prefix, suffix: photo.suffix) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.presenter?.addImages(of: [data])
                            if let id = venue?.id {
                                self.venueService.save(images: [data], id: id)
                            }
                        }
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }
}

//
//  VenuePresenter.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 20.03.2024.
//

import UIKit

// от view
protocol VenuePresenterProtocolInput: AnyObject {
    func viewDidLoaded(id: String?)
    
    func createNewEvent(with id: String, title: String)
}

// от interactor
protocol VenuePresenterProtocolOutput: AnyObject {
    func updateView(with venue: VenueDetailes?)
    
    func setMainImage(with imageData: Data)
    
    func addImages(of imagesData: [Data])
}

class VenuePresenter {
    weak var view: VenueViewProtocol?
    var router: VenueRouterProtocol
    var interactor: VenueInteractorProtocol
    
    var newEventAssembly: NewEventAssembly
    
    init(router: VenueRouterProtocol, interactor: VenueInteractorProtocol, newEventAssembly: NewEventAssembly) {
        self.router = router
        self.interactor = interactor
        self.newEventAssembly = newEventAssembly
    }
    
}

extension VenuePresenter: VenuePresenterProtocolInput {
    func viewDidLoaded(id: String?) {
        if let id = id {
            interactor.loadVenueDetailes(with: id)
        }
    }
    
    func createNewEvent(with id: String, title: String) {
        router.presentEventController(newEventAssembly: newEventAssembly, with: id, title: title)
    }
}

extension VenuePresenter: VenuePresenterProtocolOutput {
    func updateView(with venue: VenueDetailes?) {
        
        let name = venue?.name ?? "Неизвестно"
        
        let categories = venue?.categories?.map { $0.shortName ?? "" } ?? []
        let category = categories.joined(separator: ", ")
        
        let contact = venue?.contact?.formattedPhone ?? "-"
        
        let adressList = venue?.location?.formattedAddress ?? []
        let adress = adressList.joined(separator: ", ")
        
        let open = venue?.hours?.status ?? "-"
        let description = venue?.description ?? "-"
        
        let timeframes = venue?.defaultHours?.timeframes ?? []
        let times = timeframes.map { "\($0.days ?? "Дни"): \($0.open.first?.renderedTime ?? "неизвестно")" }
        var workTime = times.joined(separator: "\n")
        if workTime.isEmpty { workTime = "-" }
        
        view?.showVenueInformation(name: name, category: category, contact: contact, adress: adress, open: open, description: description, workTime: workTime)
    }
    
    func setMainImage(with imageData: Data) {
        let image = UIImage(data: imageData)
        view?.showMainImage(image: image)
    }
    
    func addImages(of imagesData: [Data]) {
        let images = imagesData.map { UIImage(data: $0) }
        view?.showImages(images: images)
    }
}


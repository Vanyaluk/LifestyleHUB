//
//  RootRouter.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

protocol RootRouterProtocol: AnyObject {
    func openVenueCard(with id: String, assembly: VenueAssembly)
}

class RootRouter: RootRouterProtocol {
    weak var viewController: RootViewController?
    
    func openVenueCard(with id: String, assembly: VenueAssembly) {
        let viewController = assembly.assemble(with: id)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}

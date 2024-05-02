//
//  NewEventRouter.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

protocol NewEventRouterProtocol {
    func dismissView()
}

class NewEventRouter: NewEventRouterProtocol {
    weak var viewController: NewEventViewController?
    
    func dismissView() {
        viewController?.dismiss(animated: true)
    }
}

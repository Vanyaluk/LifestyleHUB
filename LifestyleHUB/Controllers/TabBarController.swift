//
//  ViewController.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    var rootAssembly: RootAssembly
    var eventsAssembly: EventsAssembly
    var profileAssemply: ProfileAssemply
    
    init(rootAssembly: RootAssembly, eventsAssembly: EventsAssembly, profileAssemply: ProfileAssemply) {
        self.rootAssembly = rootAssembly
        self.eventsAssembly = eventsAssembly
        self.profileAssemply = profileAssemply
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setViewControllers([
            navigationView(with: "Главная", systemImage: "list.bullet.below.rectangle", viewController: rootAssembly.assemble()),
            
            navigationView(with: "Мой досуг", systemImage: "bookmark", viewController: eventsAssembly.assemble()),
            
            navigationView(with: "Профиль", systemImage: "person.crop.circle", viewController: profileAssemply.assemble())
            
        ], animated: true)
    }
    
    // создание navigation view
    private func navigationView(with title: String, systemImage: String, viewController: UIViewController) -> UINavigationController {
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.tabBarItem.title = title
        navigationView.tabBarItem.image = UIImage(systemName: systemImage)
        return navigationView
    }
}

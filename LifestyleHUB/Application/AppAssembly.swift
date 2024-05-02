//
//  AppAssembly.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 25.03.2024.
//

import UIKit

final class AppAssembly {
    func assemble() -> UITabBarController {
        let weatherService = WeatherService()
        let venueService = VenueService()
        let randomUserService = RandomUserService()
        let locationManager = LocationManager()
        let notificationManager = NotificationManager()
        
        let newEventAssembly = NewEventAssembly(notificationManager: notificationManager)
        let venueAssemble = VenueAssembly(venueService: venueService, newEventAssembly: newEventAssembly)
        
        let rootAssembly = RootAssembly(weatherService: weatherService, locationManager: locationManager, venueService: venueService, newEventAssembly: newEventAssembly, venueAssembly: venueAssemble)
        
        let eventsAssembly = EventsAssembly(newEventAssembly: newEventAssembly, venueAssembly: venueAssemble, notificationManager: notificationManager)
        
        let profileAssemply = ProfileAssemply(loginAssembly: LoginAssembly(), registerAssembly: RegisterAssembly(randomUserService: randomUserService))
        
        let tabBar = TabBarController(rootAssembly: rootAssembly, eventsAssembly: eventsAssembly, profileAssemply: profileAssemply)
        
        return tabBar
    }
}

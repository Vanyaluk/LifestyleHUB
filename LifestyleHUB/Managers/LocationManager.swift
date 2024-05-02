//
//  LocationService.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 17.03.2024.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager: CLLocationManager
    private var currentLocation: CLLocation?
    private var completion: ((Double, Double) -> Void)?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation(completion: @escaping (Double, Double) -> Void) {
        if let location = currentLocation {
            completion(location.coordinate.latitude, location.coordinate.longitude)
            return
        }
        
        self.completion = completion
        
        if locationManager.authorizationStatus == .authorizedWhenInUse ||
           locationManager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        if let completion = completion {
            completion(location.coordinate.latitude, location.coordinate.longitude)
            self.completion = nil
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let completion = completion {
            completion(0.0, 0.0) // Возвращаем значения по умолчанию в случае ошибки
            self.completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}

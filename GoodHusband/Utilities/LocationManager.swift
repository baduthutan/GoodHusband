//
//  LocationManager.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func requestLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        manager.requestLocation()
        
        let _ = $location
            .compactMap { $0 }
            .sink { location in
                completion(.success(location))
            }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

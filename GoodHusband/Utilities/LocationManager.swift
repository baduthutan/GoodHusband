//
//  LocationManager.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var locationHandler: ((CLLocation?) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation(completion: @escaping (CLLocation?) -> Void) {
        locationHandler = completion
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationHandler?(locations.first)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationHandler?(nil)
    }
}



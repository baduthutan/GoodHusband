//
//  MapViewModel.swift
//  GoodHusband
//
//  Created by Agfi on 11/07/24.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results = [MKMapItem]()
    @Published var route: MKRoute?
    @Published var routeDestination: MKMapItem?
    @Published var showDetails = false
    @Published var routeDisplaying = false
    @Published var userLocation: CLLocation?
    
    private var locationManager = LocationManager()
    
    static let singleton = MapViewModel()
    
    private init() {}
    
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        
        DispatchQueue.main.async {
            self.results = response?.mapItems ?? []
            self.showDetails = false
        }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: -6.2, longitude: 106.8)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

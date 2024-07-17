//
//  LocationHeaderViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 16/07/24.
//

import Foundation
import SwiftUI
import CoreLocation

class LocationHeaderViewModel: ObservableObject {
    @Published var location: String = "Loading..."
    @Published var headerWeatherDisplay: HeaderWeatherDisplay
    @Published var weatherDescription: String = "Loading Weather..."
    @Published var textColor: Color = .black
    
    private let weatherViewModel = WeatherViewModel.singleton
    private let locationManager = LocationManager()
    
    init() {
        self.headerWeatherDisplay = HeaderWeatherDisplay(
            backgroundImage: .bgSunny,
            image: .sunnyHeader
        )
        
        weatherViewModel.fetchDailyForecast {
            self.getLocationName()
            self.getWeatherDescription()
        }
    }
    
    private func getLocationName() {
        locationManager.requestLocation { result in
            switch result {
            case .success(let location):
                self.reverseGeocodeLocation(location) { locationString in
                    DispatchQueue.main.async {
                        self.location = locationString
                    }
                }
            case .failure(let error):
                print("Failed to get location: \(error.localizedDescription)")
                self.location = "Failed to get location"
            }
        }
    }
    
    private func reverseGeocodeLocation(_ location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Failed to reverse geocode location: \(error.localizedDescription)")
                completion("Failed to get location")
                return
            }
            
            if let placemark = placemarks?.first {
                let locality = placemark.locality ?? ""
                let administrativeArea = placemark.administrativeArea ?? ""
                
                let locationString = "\(locality), \(administrativeArea)"
                completion(locationString)
            } else {
                completion("Unknown Location")
            }
        }
    }
    
    
    private func getWeatherDescription() {
        DispatchQueue.main.async {
            let weatherData = self.weatherViewModel.weatherForecasts[0]
            let isRainingNow = self.weatherViewModel.isRainingNow
            
            if isRainingNow {
                self.weatherDescription = "It's raining right now"
                self.textColor = .white
                self.headerWeatherDisplay = HeaderWeatherDisplay(
                    backgroundImage: .bgRaining,
                    image: .rainHeader
                )
            } 
            else if weatherData.rainChance < 40 {
                self.weatherDescription = "It will be sunny all day"
                self.headerWeatherDisplay = HeaderWeatherDisplay(
                    backgroundImage: .bgSunny,
                    image: .sunnyHeader
                )
            } 
            else {
                self.weatherDescription = "It seems like it's gonna rain"
                self.headerWeatherDisplay = HeaderWeatherDisplay(
                    backgroundImage: .bgWillRain,
                    image: .willRainHeader
                )
            }
        }
    }}

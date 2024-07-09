//
//  WeatherService.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

protocol WeatherServiceProtocol {
    func fetchWeather(completion: @escaping (Result<Weather, Error>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    private let weatherKit = WeatherService.fetchWeather(WeatherService)
    private let locationManager = LocationManager()
    
    func fetchWeather(completion: @escaping (Result<Weather, Error>) -> Void) {
        locationManager.requestLocation { location in
            guard let location = location else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Location not available"])))
                return
            }
            Task {
                do {
                    let weather = try await weatherKit.weather(for: location)
                    let currentWeather = Weather(temperature: weather.currentWeather.temperature.value, condition: weather.currentWeather.condition.rawValue)
                    completion(.success(currentWeather))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}



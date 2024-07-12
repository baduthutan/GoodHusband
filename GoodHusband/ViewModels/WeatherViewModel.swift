//
//  WeatherViewModel.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weatherModel: WeatherModel?
    @Published var weatherForecasts: [WeatherModel] = []
    
    private var weatherManager = WeatherManager()
    private var locationManager = LocationManager()
    
    func fetchWeather() {
        Task {
            do {
                if let location = locationManager.location {
                    let weatherModel = try await weatherManager.fetchWeather(location: location)
                    DispatchQueue.main.async {
                        self.weatherModel = weatherModel
                    }
                }
            } catch {
                print("Failed to get weather data. \(error)")
            }
        }
    }
    
    func fetchDailyForecast() {
        Task {
            do {
                if let location = locationManager.location {
                    let weatherForecast = try await weatherManager.fetchWeatherForecast(location: location)
                    DispatchQueue.main.async {
                        self.weatherForecasts = weatherForecast
                    }
                }
            } catch {
                print("Failed to get weather data. \(error)")
            }
        }
    }
}



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
    @Published var isRainingNow: Bool = false
    @Published var weatherForecastsDestination: [WeatherModel] = []
    
    private var weatherManager = WeatherManager()
    private var locationManager = LocationManager()
    
    private var isFetching = false
    
    static let singleton = WeatherViewModel()
    
    private init() {}
    
    func fetchIsRainingNow() {
        let keywords = ["rain", "bolt", "drizzle"]
        
        Task {
            do {
                if let location = locationManager.location {
                    let weatherSymbol = try await weatherManager.fetchCurrentWeatherSymbol(location: location)
                    DispatchQueue.main.async {
                        if keywords.contains(where: { weatherSymbol.contains($0) }) {
                            self.isRainingNow = true
                        } else {
                            self.isRainingNow = false
                        }
                    }
                }
            } catch {
                print("Failed to get weather data. \(error)")
            }
        }
    }
    
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
    
    func fetchDailyForecast(completion: @escaping() -> Void) {
        if weatherForecasts.isEmpty || !isFetching {
            isFetching = true
            Task {
                do {
                    if let location = locationManager.location {
                        let weatherForecast = try await weatherManager.fetchWeatherForecast(location: location)
                        DispatchQueue.main.async {
                            self.weatherForecasts = weatherForecast
                            self.isFetching = false
                            completion()
                        }
                    }
                } catch {
                    print("Failed to get weather data. \(error)")
                    self.isFetching = false
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    func fetchWeeklyForecast(for latitude: Double, longitude: Double, completion: @escaping() -> Void) {
        Task {
            do {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                let weatherForecastsDestination = try await weatherManager.fetchWeatherForecast(location: location)
                DispatchQueue.main.async {
                    self.weatherForecastsDestination = weatherForecastsDestination
                }
            } catch {
                print("Failed to get weather data. \(error)")
            }
        }
    }
}

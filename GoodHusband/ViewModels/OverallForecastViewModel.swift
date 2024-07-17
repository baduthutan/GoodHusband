//
//  OverallForecastViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 17/07/24.
//

import Foundation
import CoreLocation

class OverallForecastViewModel: ObservableObject {
    @Published var location = "Loading..."
    @Published var temperature = 0
    @Published var weatherImageName = ""
    @Published var recommendationModels: [RecommendationModel] = []
    
    private let weatherViewModel = WeatherViewModel.singleton
    private let locationManager = LocationManager()
    
    init() {
        weatherViewModel.fetchDailyForecast {
            self.getLocationName()
            self.getTemperatureData()
            self.getRecommendations()
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
    
    private func getTemperatureData() {
        let weatherData = self.weatherViewModel.weatherForecasts[0]
        
        self.temperature = weatherData.temperature
        self.weatherImageName = weatherData.conditionSymbolName
    }
    
    private func getRecommendations() {
        let weatherData = self.weatherViewModel.weatherForecasts[0]
        
        appendTemperatureRecommendations(for: weatherData)
        appendUVIndexRecommendation(for: weatherData)
        appendRainChanceRecommendations(for: weatherData)
        appendHumidityRecommendations(for: weatherData)
    }

    private func appendTemperatureRecommendations(for weatherData: WeatherModel) {
        if weatherData.temperature >= 30 {
            recommendationModels.append(contentsOf: [
                RecommendationModel(
                    imageName: "NoThickClothes",
                    title: "Avoid thick clothes.",
                    description: "Wear a comfortable outfit that easily absorbs sweat and avoid dressing in layers."
                ),
                RecommendationModel(
                    imageName: "UmbrellaHot",
                    title: "Get an umbrella if you need to.",
                    description: "In \(weatherData.temperature)°C, maybe it’s a good idea to have an umbrella with you to avoid direct sunlight."
                )
            ])
        } else if weatherData.temperature < 24 {
            recommendationModels.append(
                RecommendationModel(
                    imageName: "WarmClothes",
                    title: "Use warm clothes.",
                    description: "With a mild \(weatherData.temperature)°C temperature, you might want to wear warm clothes during your activities."
                )
            )
        }
    }

    private func appendUVIndexRecommendation(for weatherData: WeatherModel) {
        if weatherData.uvIndex >= 6 {
            recommendationModels.append(
                RecommendationModel(
                    imageName: "UseSunscreen",
                    title: "Don’t forget your sunscreen!",
                    description: "The overall UV Index quite high today. Use sunscreen and re-apply every 4 hours."
                )
            )
        }
    }

    private func appendRainChanceRecommendations(for weatherData: WeatherModel) {
        if weatherData.rainChance >= 40 {
            recommendationModels.append(
                RecommendationModel(
                    imageName: "UmbrellaBring",
                    title: "You’ll need an umbrella.",
                    description: "With \(weatherData.rainChance)% chance of rain, it’ll be rainy all day. Bring your umbrella (or raincoat) with you."
                )
            )
        } else if weatherData.rainChance >= 20 {
            recommendationModels.append(
                RecommendationModel(
                    imageName: "UmbrellaReady",
                    title: "Bring a raincoat (or an umbrella)",
                    description: "There’s a \(weatherData.rainChance)% chance that it’ll rain today. Be prepared for the worst."
                )
            )
        }
    }

    private func appendHumidityRecommendations(for weatherData: WeatherModel) {
        if weatherData.humidity >= 60 || weatherData.rainChance >= 40 {
            recommendationModels.append(
                RecommendationModel(
                    imageName: "NoLaundry",
                    title: "Not the best day for doing laundry.",
                    description: "The overall humidity is at \(weatherData.humidity)% today. It might be best if you postpone your laundry agenda."
                )
            )
        } else {
            recommendationModels.append(
                RecommendationModel(
                    imageName: "DoLaundry",
                    title: "Time for doing laundry!",
                    description: "With \(weatherData.humidity)% humidity today, you’ll be able to dry your clothes. It’s perfect for doing laundry!"
                )
            )
        }
    }
}

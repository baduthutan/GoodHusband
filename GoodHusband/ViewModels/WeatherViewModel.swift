//
//  WeatherViewModel.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    private var weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func fetchWeather() {
        weatherService.fetchWeather { [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.weather = weather
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


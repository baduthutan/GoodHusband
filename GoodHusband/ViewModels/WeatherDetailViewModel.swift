//
//  WeatherDetailViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 16/07/24.
//

import Foundation

class WeatherDetailViewModel: ObservableObject {
    let imageName: WeatherDataEnums
    @Published var value: Int
    
    private var weatherViewModel = WeatherViewModel.singleton
    
    init(imageName: WeatherDataEnums) {
        self.imageName = imageName
        self.value = 0
        
        weatherViewModel.fetchDailyForecast {
            self.fetchWeatherDetailValue()
        }
    }
    
    func fetchWeatherDetailValue() {
        let weatherData = weatherViewModel.weatherForecasts[0]
        
        switch imageName {
        case .rainChance:
            self.value = weatherData.rainChance
        case .uvIndex:
            self.value =  weatherData.uvIndex
        case .humidity:
            self.value = weatherData.humidity
        }
        
    }
    
}

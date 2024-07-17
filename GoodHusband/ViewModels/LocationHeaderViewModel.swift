//
//  LocationHeaderViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 16/07/24.
//

import Foundation

class LocationHeaderViewModel: ObservableObject {
    @Published var location: String = "Loading..."
    @Published var weatherDescription: String = "Loading Weather..."
    
    private var weatherViewModel = WeatherViewModel.singleton
    
    init() {
        weatherViewModel.fetchDailyForecast {
            self.getLocationName()
            self.getWeatherDescription()
        }
    }
    
    private func getLocationName() {
        DispatchQueue.main.async {
            self.location = "Placeholder Location"
        }
    }
    
    private func getWeatherDescription() {
        DispatchQueue.main.async {
            var weatherData: WeatherModel?
            if !self.weatherViewModel.weatherForecasts.isEmpty{
                weatherData = self.weatherViewModel.weatherForecasts[0]
            }
            let isRainingNow = self.weatherViewModel.isRainingNow
            
            if isRainingNow {
                self.weatherDescription = "It's raining right now"
            } else if (weatherData?.rainChance ?? 0) < 40 {
                self.weatherDescription = "It will be sunny all day"
            } else {
                self.weatherDescription = "It seems like it's gonna rain"
            }
        }
    }
}

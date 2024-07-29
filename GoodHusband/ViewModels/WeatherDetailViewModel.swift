//
//  WeatherDetailViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 16/07/24.
//

import Foundation
import Combine

class WeatherDetailViewModel: ObservableObject {
    let imageName: WeatherDataEnums
    @Published var value: Int
    
    private var overallForecastViewModel: OverallForecastViewModel
    
    init(imageName: WeatherDataEnums, overallForecastViewModel: OverallForecastViewModel) {
        self.imageName = imageName
        self.value = 0
        self.overallForecastViewModel = overallForecastViewModel
        
        self.overallForecastViewModel.$currentWeatherData.sink { [weak self] weatherData in
            self?.fetchWeatherDetailValue(for: weatherData)
        }.store(in: &cancellables)
        
        fetchWeatherDetailValue(for: overallForecastViewModel.currentWeatherData)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeatherDetailValue(for weatherData: WeatherModel?) {
        guard let weatherData = weatherData else { return }
        
        switch imageName {
        case .rainChance:
            self.value = weatherData.rainChance
        case .uvIndex:
            self.value = weatherData.uvIndex
        case .humidity:
            self.value = weatherData.humidity
        }
    }
}

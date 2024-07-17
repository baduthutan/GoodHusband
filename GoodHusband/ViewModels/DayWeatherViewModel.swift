//
//  DayWeatherViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 17/07/24.
//

import Foundation

class DayWeatherViewModel:ObservableObject {
    @Published var dayWeather: DayWeatherModel
    
    init(dayWeather: DayWeatherModel) {
        self.dayWeather = dayWeather
    }
}

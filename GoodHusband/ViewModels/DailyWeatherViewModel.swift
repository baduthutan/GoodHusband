//
//  DailyWeatherViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 17/07/24.
//

import Foundation

class DailyWeatherViewModel: ObservableObject {
    @Published var dailyForecasts: [DayWeatherModel] = []
    
    private var weatherViewModel = WeatherViewModel.singleton
    
    init() {
        weatherViewModel.fetchDailyForecast {
            self.getDayWeathers()
        }
    }
    
    private func getDayWeathers() {
        let today = Calendar.current.startOfDay(for: Date())
        
        for weather in weatherViewModel.weatherForecasts {
            let weatherDate = Calendar.current.startOfDay(for: weather.date)
            let isToday = weatherDate == today
            
            let day = isToday ? "Today" : convertDateToDay(date: weather.date)
            
            let dayWeather = DayWeatherModel(
                day: day,
                symbol: weather.conditionSymbolName,
                temperature: weather.temperature,
                isActive: isToday
            )
            
            dailyForecasts.append(dayWeather)
        }
    }
    
    private func convertDateToDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        
        let dayFormat = formatter.string(from: date)
        
        return dayFormat
    }
}

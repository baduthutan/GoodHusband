//
//  WeatherManager.swift
//  GoodHusband
//
//  Created by Dixon Willow on 12/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherManager {
    private let weatherService = WeatherService()
    
    func fetchWeather(location: CLLocation) async throws -> WeatherModel {
        let weather = try await weatherService.weather(for: location)
        
        let currentWeather = weather.currentWeather
        let todayWeather = weather.dailyForecast.first
        
        let weatherDate = currentWeather.date
        let weatherCondition = currentWeather.condition.rawValue
        let conditionSymbolName: String = currentWeather.symbolName
        let temperature = Int(currentWeather.apparentTemperature.value.rounded())
        let rainChance = Int(((todayWeather?.precipitationChance ?? 0.0) * 100).rounded())
        let uvIndex = Int(currentWeather.uvIndex.value)
        let humidity = Int((currentWeather.humidity * 100).rounded())
        
        return WeatherModel(
            date: weatherDate,
            weatherCondition: weatherCondition,
            conditionSymbolName: conditionSymbolName,
            temperature: temperature,
            rainChance: rainChance,
            uvIndex: uvIndex,
            humidity: humidity
        )
    }
    
    func fetchWeatherForecast(location: CLLocation) async throws -> [WeatherModel] {
        let weather = try await weatherService.weather(for: location)
        var weatherModels: [WeatherModel] = []
        
        for dayWeather in weather.dailyForecast.prefix(7) {
            let weatherDate = dayWeather.date
            let weatherCondition = dayWeather.condition.rawValue
            let conditionSymbolName = dayWeather.symbolName
            let temperature = try await getDayFeelsLikeTemperature(for: weatherDate, location: location)
            let rainChance = Int((dayWeather.precipitationChance * 100).rounded())
            let uvIndex = dayWeather.uvIndex.value
            let humidity = try await getDailyHumidity(for: weatherDate, location: location)
            
            let weatherModel = WeatherModel(
                date: weatherDate,
                weatherCondition: weatherCondition,
                conditionSymbolName: conditionSymbolName,
                temperature: temperature,
                rainChance: rainChance,
                uvIndex: uvIndex,
                humidity: humidity
            )
            weatherModels.append(weatherModel)
        }
        
        return weatherModels
    }
    
    private func getDayFeelsLikeTemperature(for date: Date, location: CLLocation) async throws -> Int {
        let hourlyForecast = try await weatherService.weather(for: location).hourlyForecast
        let calendar = Calendar.current
        let dayComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let dailyFeelsLikeTemperatures = hourlyForecast
            .filter { calendar.dateComponents([.year, .month, .day], from: $0.date) == dayComponents }
            .map { $0.apparentTemperature.value }
        
        guard let maxFeelsLikeTemperature = dailyFeelsLikeTemperatures.max() else {
            return -100
        }
        
        return Int(maxFeelsLikeTemperature.rounded())
    }
    
    private func getDailyHumidity(for date: Date, location: CLLocation) async throws -> Int {
        let hourlyForecast = try await weatherService.weather(for: location).hourlyForecast
        let calendar = Calendar.current
        let dayComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let dailyHumidityValues = hourlyForecast
            .filter { calendar.dateComponents([.year, .month, .day], from: $0.date) == dayComponents }
            .map { $0.humidity }
        
        guard !dailyHumidityValues.isEmpty else {
            return -1 // Or any default value you consider appropriate
        }
        
        let averageHumidity = dailyHumidityValues.reduce(0, +) / Double(dailyHumidityValues.count)
        return Int(averageHumidity.rounded())
    }
}


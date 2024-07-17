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
    
    func fetchCurrentWeatherSymbol(location: CLLocation) async throws -> String {
        let weather = try await weatherService.weather(for: location)
        
        let currenWeather = weather.currentWeather
        
        let weatherSymbol = currenWeather.symbolName
        
        return weatherSymbol
    }
    
    func fetchWeather(location: CLLocation) async throws -> WeatherModel {
        let weather = try await weatherService.weather(for: location)
        
        let dayWeather = weather.dailyForecast.first
        
        let weatherDate = dayWeather?.date
        let conditionSymbolName = dayWeather?.symbolName ?? ""
        let temperature = try await getDayFeelsLikeTemperature(for: weatherDate ?? Date(), location: location)
        let rainChance = Int(((dayWeather?.precipitationChance ?? -1.0) * 100).rounded())
        let uvIndex = dayWeather?.uvIndex.value ?? -1
        let humidity = try await getDailyHumidity(for: weatherDate ?? Date(), location: location)
        
        return WeatherModel(
            date: weatherDate ?? Date(),
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
            let conditionSymbolName = dayWeather.symbolName
            let temperature = try await getDayFeelsLikeTemperature(for: weatherDate, location: location)
            let rainChance = Int((dayWeather.precipitationChance * 100).rounded())
            let uvIndex = dayWeather.uvIndex.value
            let humidity = try await getDailyHumidity(for: weatherDate, location: location)
            
            let weatherModel = WeatherModel(
                date: weatherDate,
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
        
        let totalHumidity = dailyHumidityValues.reduce(0, +)
        let averageHumidity = Double(totalHumidity) / Double(dailyHumidityValues.count) * 100
        return Int(averageHumidity.rounded())
    }
}


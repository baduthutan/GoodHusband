//
//  DailyWeatherView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DailyWeatherView: View {
    private let weatherViewModel = WeatherViewModel.singleton
    let weekWeather: [DayWeather] = [
        DayWeather(day: "Today", icon: "sun.max.fill", temperature: "29°"),
        DayWeather(day: "TUE", icon: "cloud.rain.fill", temperature: "21°"),
        DayWeather(day: "WED", icon: "cloud.rain.fill", temperature: "19°"),
        DayWeather(day: "THU", icon: "cloud.bolt.fill", temperature: "19°"),
        DayWeather(day: "FRI", icon: "cloud.sun.rain.fill", temperature: "19°"),
        DayWeather(day: "SAT", icon: "cloud.sun.rain.fill", temperature: "19°"),
        DayWeather(day: "SUN", icon: "cloud.sun.rain.fill", temperature: "19°")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(weekWeather) { dayWeather in
                    DayWeatherView(dayWeather: dayWeather)
                }
            }
        }
    }
}


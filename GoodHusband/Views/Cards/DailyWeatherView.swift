//
//  DailyWeatherView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DailyWeatherView: View {
    let weekWeather: [DayWeather] = [
        DayWeather(day: "Today", icon: "sun.max.fill", temperature: "29°", isActive: true),
        DayWeather(day: "TUE", icon: "cloud.rain.fill", temperature: "21°", isActive: false),
        DayWeather(day: "WED", icon: "cloud.rain.fill", temperature: "19°", isActive: false),
        DayWeather(day: "THU", icon: "cloud.bolt.fill", temperature: "19°", isActive: false),
        DayWeather(day: "FRI", icon: "cloud.sun.rain.fill", temperature: "19°", isActive: false),
        DayWeather(day: "SAT", icon: "cloud.sun.rain.fill", temperature: "19°", isActive: false),
        DayWeather(day: "SAT", icon: "cloud.sun.rain.fill", temperature: "19°", isActive: false)
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(weekWeather) { dayWeather in
                    DayWeatherView(dayWeather: dayWeather)
                }
            }
        }
    }
}

#Preview {
    DailyWeatherView()
        .padding()
}

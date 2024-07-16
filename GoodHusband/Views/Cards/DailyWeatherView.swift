//
//  DailyWeatherView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DayWeather: Identifiable {
    let id = UUID()
    let day: String
    let icon: String
    let temperature: String
}

struct DayWeatherView: View {
    var dayWeather: DayWeather
    
    var body: some View {
        VStack(spacing: 8) {
            Text(dayWeather.day)
                .font(.system(size: 15))
            Image(systemName: dayWeather.icon)
                .resizable()
                .frame(width: 24, height: 24)
                .aspectRatio(contentMode: .fit)
            Text(dayWeather.temperature)
                .font(.system(size: 15))
        }
        .frame(width: 52, height: 86)
    }
}

struct DailyWeatherView: View {
    let weekWeather: [DayWeather] = [
        DayWeather(day: "Today", icon: "sun.max.fill", temperature: "29°"),
        DayWeather(day: "TUE", icon: "cloud.rain.fill", temperature: "21°"),
        DayWeather(day: "WED", icon: "cloud.rain.fill", temperature: "19°"),
        DayWeather(day: "THU", icon: "cloud.bolt.fill", temperature: "19°"),
        DayWeather(day: "FRI", icon: "cloud.sun.rain.fill", temperature: "19°"),
        DayWeather(day: "SAT", icon: "cloud.sun.rain.fill", temperature: "19°")
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

#Preview {
    DailyWeatherView()
        .padding()
}

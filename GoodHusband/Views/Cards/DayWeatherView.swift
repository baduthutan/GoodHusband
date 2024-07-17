//
//  DayWeatherView.swift
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
    let isActive: Bool
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
            
            VStack(spacing: 0.0) {
                if dayWeather.isActive {
                    Rectangle()
                        .fill(.primary)
                        .frame(height: 2)
                }else{
                    Rectangle()
                        .fill(Color("BgCard"))
                        .frame(height: 2)
                }
                Rectangle()
                    .fill(.secondary)
                .frame(height: 2)
            }
        }
        .frame(width: 52, height: 86)
    }
}

#Preview {
    DayWeatherView(
        dayWeather: DayWeather(
            day: "Today",
            icon: "sun.max.fill",
            temperature: "29°", isActive: true
        )
    )
}

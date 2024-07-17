//
//  DayWeatherView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DayWeatherView: View {
    @ObservedObject var dayWeatherViewModel: DayWeatherViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            Text(dayWeatherViewModel.dayWeather.day)
                .font(.system(size: 15))
            Image(systemName: dayWeatherViewModel.dayWeather.symbol)
                .resizable()
                .frame(width: 24, height: 24)
                .aspectRatio(contentMode: .fit)
            Text("\(dayWeatherViewModel.dayWeather.temperature)°")
                .font(.system(size: 15))
            
            VStack(spacing: 0.0) {
                if dayWeatherViewModel.dayWeather.isActive {
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
        dayWeatherViewModel: DayWeatherViewModel(
            dayWeather: DayWeatherModel(
                day: "Today",
                symbol: "sun.max.fill",
                temperature: 29,
                isActive: true
            )
        )
    )
}

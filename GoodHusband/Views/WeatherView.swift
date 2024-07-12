//
//  WeatherView.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            if let weatherModel = weatherViewModel.weatherModel {
                Image(systemName: weatherModel.conditionSymbolName)
                    .font(.largeTitle)
                    .shadow(radius: 2)
                    .padding()
                Text("\(weatherModel.weatherCondition)")
                Text("Chance of rain: \(weatherModel.rainChance)%")
                Text("Temperature: \(weatherModel.temperature) C")
                Text("Humidity: \(weatherModel.humidity)%")
            } else {
                Text("failed to fetch data")
            }
        }
        .onAppear {
            Task {
                weatherViewModel.fetchWeather()
            }
        }
        .font(.title3)
    }
}

#Preview {
    WeatherView()
}

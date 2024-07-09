//
//  ContentView.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            WeatherView(weather: weatherViewModel.weather)
                .onAppear {
                    weatherViewModel.fetchWeather()
                }
                .navigationTitle("Weather App")
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import SwiftUI

struct ContentView: View {
    private let weatherViewModel = WeatherViewModel.singleton
    private let mapViewModel = MapViewModel.singleton
    
    var body: some View {
//        DetailView(
//            location: "Summarecon, Bekasi",
//            weatherCondition: "It’s Sunny all day!",
//            weatherConditionDesc: "It doesn’t seem like going to rain there today."
//        )
        MainView()
            .onAppear {
                Task {
                    weatherViewModel.fetchIsRainingNow()
                }
            }
    }
}

#Preview {
    ContentView()
}

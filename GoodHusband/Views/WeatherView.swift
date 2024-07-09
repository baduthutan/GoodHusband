//
//  WeatherView.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import SwiftUI

struct WeatherView: View {
    var weather: Weather?
    
    var body: some View {
        VStack {
            if let weather = weather {
                Text("Temperature: \(weather.temperature)°C")
                Text("Condition: \(weather.condition)")
            } else {
                Text("Loading...")
            }
        }
    }
}


#Preview {
    WeatherView()
}

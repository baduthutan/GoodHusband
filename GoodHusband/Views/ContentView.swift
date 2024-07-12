//
//  ContentView.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var mapViewModel = MapViewModel()
    
    var body: some View {
        MapView(mapViewModel: mapViewModel, weatherViewModel: weatherViewModel)
    }
}

#Preview {
    ContentView()
}

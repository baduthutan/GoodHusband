//
//  MainView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack{
            VStack(spacing: 16) {
                LocationHeaderView(location: "SERPONG, TANGERANG", weatherDescription: "It’s Sunny all day!")
                DestinationCardView(destination: "Summarecon", location: "Bekasi", humidity: 52, temperature: 28, weatherIcon: "cloud.sun.fill", isPinned: true)
                Spacer()
            }
            .padding(.top)
            .background(Color(UIColor.systemGroupedBackground))
            .ignoresSafeArea()
            MapView(mapViewModel: MapViewModel(), weatherViewModel: WeatherViewModel())
                .padding(.top, 130)
        }
    }
}

#Preview {
    MainView()
}

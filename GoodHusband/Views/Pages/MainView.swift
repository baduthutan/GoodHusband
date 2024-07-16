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
            VStack(spacing: 10) {
                LocationHeaderView(location: "SERPONG, TANGERANG", weatherDescription: "It’s Sunny all day!")
                PinnedLocationView(location: "Summarecon", isRainy: true)
                Spacer()
            }
            .padding(.top)
            .background(Color(UIColor.systemGroupedBackground))
            .ignoresSafeArea()
            MapView(mapViewModel: MapViewModel(), weatherViewModel: WeatherViewModel())
                .padding(.top, 140)
        }
    }
}

#Preview {
    MainView()
}

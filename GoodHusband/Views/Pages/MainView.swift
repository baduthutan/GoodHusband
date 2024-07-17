//
//  MainView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct MainView: View {
    
    private let weatherViewModel = WeatherViewModel.singleton
    private let mapViewModel = MapViewModel.singleton
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack{
                    LocationHeaderView()
                        .padding(.bottom,10)
                    PinnedLocationView(location: "Summarecon", isRainy: true)
                        .padding(.bottom,0)
                    OverallForecastView(location: "BSD, Tangerang")
                    Spacer()
                }
                .background(Color("BgPage"))
                MapView()
                .padding(.top, 195)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}

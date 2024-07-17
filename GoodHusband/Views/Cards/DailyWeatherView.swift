//
//  DailyWeatherView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var dailyWeatherViewModel = DailyWeatherViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(dailyWeatherViewModel.dailyForecasts) { dayWeather in
                    DayWeatherView(dayWeatherViewModel: DayWeatherViewModel(dayWeather: dayWeather))
                }
            }
        }
    }
}


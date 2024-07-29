//
//  SwiftUIView.swift
//  GoodHusband
//
//  Created by vin chen on 17/07/24.
//

import SwiftUI

struct OverallForecastView: View {
    
    @ObservedObject var overallForecastViewModel = OverallForecastViewModel()
    @StateObject var dailyWeatherViewModel = DailyWeatherViewModel()
    
    var body: some View {
        VStack{
            VStack(spacing: 12.0){
                HStack{
                    Image(systemName: "location")
                        .font(.system(size: 14))
                    Text("overall forecast in \(overallForecastViewModel.location)")
                        .font(.system(size: 11))
                        .textCase(.uppercase)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    Spacer()
                }
                DailyWeatherView(dailyWeatherViewModel: dailyWeatherViewModel)
                HStack{
                    TemperatureView(temperatureViewModel: TemperatureViewModel(
                            weatherImageName: overallForecastViewModel.weatherImageName, temperature: overallForecastViewModel.temperature
                        )
                    )
                    .previewLayout(.sizeThatFits)
                    Spacer()
                    HStack {
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .rainChance, overallForecastViewModel: overallForecastViewModel), background: Color("BGCardSecondary"), foreground: Color("ForegroundColor"))
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .uvIndex, overallForecastViewModel: overallForecastViewModel), background: Color("BGCardSecondary"), foreground: Color("ForegroundColor"))
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .humidity, overallForecastViewModel: overallForecastViewModel), background: Color("BGCardSecondary"), foreground: Color("ForegroundColor"))
                    }
                }
                ForEach(overallForecastViewModel.recommendationModels) { recommendation in
                    RecommendationView(recommendationViewModel: RecommendationViewModel(recommendation: recommendation))
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color("BgCard"))
        .cornerRadius(10)
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.2), radius: 2)
        .onAppear {
            dailyWeatherViewModel.delegate = overallForecastViewModel
        }
    }
}

#Preview {
    OverallForecastView()
}

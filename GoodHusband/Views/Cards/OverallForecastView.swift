//
//  SwiftUIView.swift
//  GoodHusband
//
//  Created by vin chen on 17/07/24.
//

import SwiftUI

struct OverallForecastView: View {
    
    @ObservedObject var overallForecastViewModel = OverallForecastViewModel()
    
    var body: some View {
        VStack{
            VStack(spacing: 12.0){
                HStack{
                    Image(systemName: "location")
                        .font(.system(size: 14))
                    Text("overall forecast in \(overallForecastViewModel.location)")
                        .font(.system(size: 11))
                        .textCase(.uppercase)
                    Spacer()
                }
                DailyWeatherView()
                HStack{
                    TemperatureView(temperatureViewModel: TemperatureViewModel(
                            weatherImageName: overallForecastViewModel.weatherImageName, temperature: overallForecastViewModel.temperature
                        )
                    )
                    .previewLayout(.sizeThatFits)
                    Spacer()
                    HStack {
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .rainChance), background: Color("BGCardSecondary"), foreground:Color("ForegroundColor"))
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .uvIndex), background: Color("BGCardSecondary"), foreground:Color("ForegroundColor"))
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .humidity), background: Color("BGCardSecondary"), foreground:Color("ForegroundColor"))
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
    }
}
#Preview {
    OverallForecastView()
}

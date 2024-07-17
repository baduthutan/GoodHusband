//
//  FavoriteDestinationView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct DestinationCardView: View {
    var temperature: Int
    var rainChance: Int
    var uvIndex: Int
    var humidity: Int
    var isPinned: Bool

    var body: some View {
        ZStack{
            Image(.sunnyDestination)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
           
            VStack(alignment:.leading, spacing: 12){
                    HStack(alignment:.center){
                        Text("\(temperature)°")
                            .foregroundColor(.black)
                            .font(.system(size: 48))
                            .bold()
                    HStack {
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .rainChance), background: .white.opacity(0.75), foreground: .black)
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .uvIndex),background: .white.opacity(0.75), foreground: .black)
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .humidity),background: .white.opacity(0.75), foreground: .black)
                            Spacer()
                    }
                }
                if isPinned == true{
                    HStack() {
                        Text("Click to see 7-day forecast")
                            .font(.caption)
                            .padding(6.0)
                        Spacer()
                            
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.75))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                }
                }
            .padding()
        }
        .background(Color(UIColor.bgSunny))
        .cornerRadius(10)
    }
}

#Preview {
    DestinationCardView(temperature: 28, rainChance: 50, uvIndex: 5, humidity: 52, isPinned: true)
}

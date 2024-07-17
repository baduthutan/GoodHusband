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
                            .font(.system(size: 48))
                            .bold()
                    HStack {
                        WeatherDetailView(imageName: "cloud.rain.fill", value: "\(rainChance)%")
                        WeatherDetailView(imageName: "sun.max", value: "UV \(uvIndex)")
                        WeatherDetailView(imageName: "humidity", value: "\(humidity)%")
                            Spacer()
                    }
                }
                if isPinned == true{
                    VStack() {
                        Text("Click to see 7-day forecast")
                            .font(.caption)
                            .padding(6.0)
                            
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.75))
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

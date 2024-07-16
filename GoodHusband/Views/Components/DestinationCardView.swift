//
//  FavoriteDestinationView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct DestinationCardView: View {
    var destination: String
    var location: String
    var humidity: Int
    var temperature: Int
    var weatherIcon: String
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
                        VStack{
                            Image(systemName: "drop.fill")
                                .foregroundColor(.black)
                            Text("\(humidity)%")
                                .font(.subheadline)
                        }
                        .frame(width: 50, height: 75)
                        .background(.white.opacity(0.75))
                        .cornerRadius(.greatestFiniteMagnitude)
                        Spacer()
                        VStack{
                            Image(systemName: "thermometer")
                                .foregroundColor(.black)
                            Text("\(temperature)°")
                                .font(.subheadline)
                        }
                        .frame(width: 50, height: 75)
                        .background(.white.opacity(0.75))
                        .cornerRadius(.greatestFiniteMagnitude)
                        Spacer()
                        VStack{
                            Image(systemName: "thermometer")
                                .foregroundColor(.black)
                            Text("\(temperature)°")
                                .font(.subheadline)
                        }
                        .frame(width: 50, height: 75)
                        .background(.white.opacity(0.75))
                        .cornerRadius(.greatestFiniteMagnitude)
                    }
                    .frame(width:160)
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
        .background(Color(UIColor.sunnyBlue))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}


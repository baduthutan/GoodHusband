//
//  DetailView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DetailView: View {
    let location: String
    let weatherCondition: String
    let weatherConditionDesc: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName:"location")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .aspectRatio(
                        contentMode: .fit)
                Text(location)
                    .font(.title2)
                    .padding(.leading, 8)
                Spacer()
            }
            .padding(.bottom, 20)
            DailyWeatherView().padding(.bottom, 22)
            Text(weatherCondition)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 6)
            Text(weatherConditionDesc)
                .padding(.bottom, 22)
            Button(action: {
                // TODO add action
            }) {
                Text("Search Other Location")
                    .frame(minWidth: 0, maxWidth: 256)
            }
            .background(.blue)
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .cornerRadius(8)
            .padding(.bottom, 16)
            Button("Pin This Information to Homepage") {
                // TODO add action
            }
            Spacer()
        }.padding(.horizontal, 16)
    }
}

#Preview {
    DetailView(
        location: "Summarecon, Bekasi",
        weatherCondition: "It’s Sunny all day!",
        weatherConditionDesc: "It doesn’t seem like going to rain there today."
    )
}

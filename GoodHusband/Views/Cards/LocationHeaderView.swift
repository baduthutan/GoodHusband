//
//  LocationHeaderView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct LocationHeaderView: View {
    
    @ObservedObject private var locationHeaderViewModel = LocationHeaderViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment:.bottom) {
                Rectangle()
                    .fill(locationHeaderViewModel.headerWeatherDisplay.backgroundImage)
                Image(locationHeaderViewModel.headerWeatherDisplay.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 12)
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top, spacing: 4, content: {
                            Image(systemName: "location")
                            Text(locationHeaderViewModel.location)
                        })
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        Text(locationHeaderViewModel.weatherDescription)
                            .font(.title)
                            .bold()
                            .foregroundColor(.primary)
                    }
                    .padding(.bottom, 10)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 36)
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.sunnyBlue, .secondary]), startPoint: .top, endPoint: .bottom)
                        )
                    .opacity(0.3)
                    .frame(height: 10)
                    
            }
            .frame(height: 230)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}



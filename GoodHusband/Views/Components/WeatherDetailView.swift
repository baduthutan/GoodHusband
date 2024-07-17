//
//  WeatherDetailView.swift
//  GoodHusband
//
//  Created by Irvan Wijaya on 16/07/24.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject var weatherDetailViewModel: WeatherDetailViewModel
    var background: Color
    var foreground: Color
    var body: some View {
        VStack {
            Image(systemName: weatherDetailViewModel.imageName.rawValue)
                .font(.system(size: 18))
                .foregroundColor(foreground)
                .padding(.bottom, 1)
            
            Text("\(weatherDetailViewModel.value)\(weatherDetailViewModel.imageName == .rainChance || weatherDetailViewModel.imageName == .humidity ? "%" : "")")
                .font(.system(size: 12))
                .foregroundColor(foreground)
        }
        .frame(width: 40, height: 65)
        .background(background)
        .cornerRadius(50)
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .rainChance), background: Color("BGCardSecondary"), foreground: .black)
            WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .uvIndex), background: Color("BGCardSecondary"), foreground: .black)
            WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .humidity), background: Color("BGCardSecondary"), foreground: .black)
        }
        .previewLayout(.sizeThatFits)
    }
}

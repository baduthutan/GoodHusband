//
//  WeatherDetailView.swift
//  GoodHusband
//
//  Created by Irvan Wijaya on 16/07/24.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject var weatherDetailViewModel: WeatherDetailViewModel
    
    var body: some View {
        VStack {
            Image(systemName: weatherDetailViewModel.imageName.rawValue)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding(.bottom, 1)
            
            Text("\(weatherDetailViewModel.value)\(weatherDetailViewModel.imageName == .rainChance || weatherDetailViewModel.imageName == .humidity ? "%" : "")")
                .font(.system(size: 12))
                .foregroundColor(.black)
        }
        .frame(width: 40, height: 65)
        .background(.white.opacity(0.75))
        .cornerRadius(50)
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .rainChance))
            WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .uvIndex))
            WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .humidity))
        }
        .previewLayout(.sizeThatFits)
    }
}

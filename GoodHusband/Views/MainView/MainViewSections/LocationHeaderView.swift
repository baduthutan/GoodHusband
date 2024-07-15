//
//  LocationHeaderView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct LocationHeaderView: View {
    var location: String
    var weatherDescription: String

    var body: some View {
        GeometryReader { geometry in
            VStack{
                    ZStack {
                        Color.sunnyBlue
                            
                        Image(.sunnyIllustration)
                            .resizable()
                            .frame(width: geometry.size.width, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                        VStack(alignment: .leading, spacing: 8){
                            Text(location)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(weatherDescription)
                                .font(.title)
                                .bold()
                                .foregroundColor(.primary)
                            Text("Set up a location to see how’s there.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 24)
                        .frame(width: geometry.size.width, alignment: .leading)
                    }
                    .frame(height: 180)
                    
                }
        }
        .edgesIgnoringSafeArea(.top)
//        .frame(height: geometry.safeAreaInsets.top + 180)
        .frame(height: 180)
    }
}

#Preview {
    MainView()
}



//
//  RecommendationView.swift
//  GoodHusband
//
//  Created by Irvan Wijaya on 16/07/24.
//

import SwiftUI

struct RecommendationView: View {
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(.infinity)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.callout)
                    .bold()
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct RecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
            .previewLayout(.sizeThatFits)
    }
}




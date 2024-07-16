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
                .cornerRadius(8)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .bold()
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 2)
    }
}

struct RecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationView(imageName: "image", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
            .previewLayout(.sizeThatFits)
    }
}




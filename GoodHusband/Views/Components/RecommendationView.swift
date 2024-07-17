//
//  RecommendationView.swift
//  GoodHusband
//
//  Created by Irvan Wijaya on 16/07/24.
//

import SwiftUI

struct RecommendationView: View {
    @ObservedObject var recommendationViewModel: RecommendationViewModel
    
    var body: some View {
        HStack {
            Image(recommendationViewModel.recommendation.imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(.infinity)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(recommendationViewModel.recommendation.title)
                    .font(.callout)
                    .bold()
                
                Text(recommendationViewModel.recommendation.description)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

struct RecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationView(
            recommendationViewModel: RecommendationViewModel(
                recommendation: RecommendationModel(
                    imageName: "WarmClothes",
                    title: "Don’t forget your sunscreen!",
                    description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours."
                )
            )
        )
        .previewLayout(.sizeThatFits)
    }
}




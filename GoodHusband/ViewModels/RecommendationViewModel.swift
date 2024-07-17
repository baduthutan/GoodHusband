//
//  RecommendationViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 17/07/24.
//

import Foundation

class RecommendationViewModel: ObservableObject {
    @Published var recommendation: RecommendationModel
    
    init(recommendation: RecommendationModel) {
        self.recommendation = recommendation
    }
}

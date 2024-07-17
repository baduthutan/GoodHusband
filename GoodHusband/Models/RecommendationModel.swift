//
//  RecommendationModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 17/07/24.
//

import Foundation

struct RecommendationModel: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    var description: String
}

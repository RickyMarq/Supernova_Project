//
//  LastLauchesModel.swift
//  Supernova
//
//  Created by Henrique Marques on 08/02/23.
//

import Foundation

struct LastLauchesModel: Codable {
    let results: [ResultedModel]
}

struct ResultedModel: Codable {
    let name: String?
    let image: String?
}
    
struct LastEventsModel: Codable {
    let results: [ResultedEvents]
}

struct ResultedEvents: Codable {
    let name: String?
    let description: String?
    let location: String?
    let videoURL: String?
    let featureImage: String?
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case location
        case videoURL = "video_url"
        case featureImage = "feature_image"
        case date
    }
}

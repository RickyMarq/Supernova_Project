//
//  SpaceStationsModel.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import Foundation

struct SpaceStationsModel: Codable {
    let results: [Resulted]
}

struct Resulted: Codable {
    let name: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }
}

//
//  YoutubePlayerModel.swift
//  Supernova
//
//  Created by Henrique Marques on 17/04/23.
//

import Foundation

struct YoutubeSearch: Codable {
    let items: [ItemYT]
}

struct ItemYT: Codable {
    let id: ID?
}

struct ID: Codable {
    let videoID: String?
    
    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}

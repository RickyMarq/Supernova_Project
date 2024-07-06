//
//  DragonsModel.swift
//  Supernova
//
//  Created by Henrique Marques on 26/01/23.
//

import Foundation

struct DragonsModel: Codable {
    let flickrImages: [String]
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case flickrImages = "flickr_images"
        case name
    }
}

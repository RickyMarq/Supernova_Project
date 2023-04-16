//
//  RocketModel.swift
//  Supernova
//
//  Created by Henrique Marques on 15/03/23.
//

import Foundation

struct RocketModel: Codable {
    let name: String?
    let active: Bool?
    let description: String?
    let total_launch_count: Int?
    let successful_launches: Int?
    let failed_launches: Int?
    let wiki_url: String?
    let manufacturer: Manufacturer
}

struct Manufacturer: Codable {
    let name: String?
    let description: String?
    let administrator: String?
    let imageURL: String?
    let total_launch_count: Int?
    let logo_url: String?
    let founding_year: String?
    let successful_launches: Int?
    let failed_launches: Int?
    let wiki_url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case administrator
        case imageURL = "image_url"
        case total_launch_count
        case logo_url
        case founding_year
        case successful_launches
        case failed_launches
        case wiki_url
    }
    
}

//
//  UpcomingModel.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import Foundation

struct UpcomingModel: Codable {
    let links: Links
    let name: String?
}

struct Links: Codable {
    let patch: Patch
    let reddit: Reddit
}

struct Patch: Codable {
    let small: String?
}

struct Reddit: Codable {
    let campaign: String?
}

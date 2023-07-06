//
//  SupernovaModel.swift
//  Supernova
//
//  Created by Henrique Marques on 21/06/23.
//

import Foundation

struct SupernovaRocketModel: Codable {
    let name, company, description: String?
    let year: Int?
    let image: String?
    let height: Int?
    let diameter, mass: String?
}


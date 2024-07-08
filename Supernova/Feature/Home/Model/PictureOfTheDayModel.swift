//
//  PictureOfTheDayModel.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import Foundation

struct PictureOfTheDay: Codable, Identifiable {
    let id = UUID()
    let date: String?
    let explanation: String?
    let title: String?
    let url: String?
}

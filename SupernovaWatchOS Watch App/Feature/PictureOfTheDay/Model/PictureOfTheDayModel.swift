//
//  PictureOfTheDayModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation

struct PictureOfTheDayModel: Codable, Identifiable {
    var id: Int?
    let date: String?
    let explanation: String?
    let title: String?
    let url: String?
    let hdurl: String?
}

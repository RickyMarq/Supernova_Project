//
//  WidgetModel.swift
//  Supernova
//
//  Created by Henrique Marques on 06/07/24.
//

import Foundation
import UIKit
import WidgetKit

struct ModelPicture: TimelineEntry {
    let date: Date
    var defaultImage: UIImage
    var widgetDate: PictureOfTheDay
}

struct PictureOfTheDay: Codable {
    let date: String?
    let explanation: String?
    let title: String?
    let url: String?
    let hdurl: String?
}

struct Model: TimelineEntry {
    var date: Date
    var widgetDate: LastLauchesModel
    var hourCountDown = 0
    var minuteCountDown = 0
    var secondCountDown = 0
    var lastUpdateTime: Date
    var launchIsClose = false
}

struct LastLauchesModel: Codable {
    let results: [ResultedModel]
}

struct ResultedModel: Codable {
    let name: String?
    let image: String?
    let lastUpdated: String?
    let windowStart: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case lastUpdated = "last_updated"
        case windowStart = "window_start"
    }
}

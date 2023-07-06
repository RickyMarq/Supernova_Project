//
//  Models.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 27/06/23.
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

struct NewsModel: Codable {
    let title: String?
    let imageUrl: String?
    let url: String?
    let summary: String?
    let newsSite: String?
    let publishedAt: String?
}

struct NewsSiteModel: Codable {
    let results: [ResultedNewsSite]

}

struct ResultedNewsSite: Codable, Identifiable {
    let id: Int?
    let title: String?
    let url: String?
    let imageURL: String?
    let newsSite: String?
    let summary: String?
    let publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case imageURL = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        
    }

}

struct LastLauchesModel: Codable {
    let results: [ResultedModel]
}

struct ResultedModel: Codable, Identifiable {
    let id: String?
    let name: String?
    let image: String?
    let lastUpdated: String?
    let windowStart: String?
    let weatherConcerns: String?
    let pad: Pad?
    let locationLaunchAttemptCount: Int?
    let padLaunchAttemptCount: Int?
    let orbitalLaunchAttemptCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case lastUpdated = "last_updated"
        case windowStart = "window_start"
        case weatherConcerns = "weather_concerns"
        case pad
        case locationLaunchAttemptCount = "location_launch_attempt_count"
        case padLaunchAttemptCount = "pad_launch_attempt_count"
        case orbitalLaunchAttemptCount = "orbital_launch_attempt_count"
    }
}

struct Pad: Codable {
    let name: String?
    let WikiUrl: String?
    let MapImage: String?
    let latitude, longitude: String?
    let launchCount: Int?
    let orbitalLaunchCount: Int?
    let agencyID: Int?
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case name
        case WikiUrl = "wiki_url"
        case MapImage = "map_image"
        case latitude
        case longitude
        case launchCount = "total_launch_count"
        case orbitalLaunchCount = "orbital_launch_attempt_count"
        case agencyID = "agency_id"
        case location
    }
}

struct Location: Codable {
    let name: String?
}

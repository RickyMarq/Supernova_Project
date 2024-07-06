//
//  LastLauchesModel.swift
//  Supernova
//
//  Created by Henrique Marques on 08/02/23.
//

import Foundation

struct LastLauchesModel: Codable {
    let next: String?
    let results: [ResultedModel]
}

struct ResultedModel: Codable {
    let status: Status?
    let name: String?
    let image: String?
    let webcastLive: Bool?
    let lastUpdated: String?
    let windowStart: String?
    let rocket: Rocket?
    let mission: MissionLaunchModel?     
    let pad: Pad?
    let launchServiceProvider: LaunchServiceProvider?
    let locationLaunchAttemptCount: Int?
    let padLaunchAttemptCount: Int?
    let orbitalLaunchAttemptCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case status
        case name
        case image
        case webcastLive = "webcast_live"
        case lastUpdated = "last_updated"
        case windowStart = "window_start"
        case rocket
        case mission
        case pad
        case locationLaunchAttemptCount = "location_launch_attempt_count"
        case padLaunchAttemptCount = "pad_launch_attempt_count"
        case orbitalLaunchAttemptCount = "orbital_launch_attempt_count"
        case launchServiceProvider = "launch_service_provider"
    }
}

//struct RocketLaunchModel: Codable {
//    let id: Int?
//}
    
struct Status: Codable {
    let abbrev: String?
}

struct MissionLaunchModel: Codable {
    let name: String?
    let description: String?
}

struct LaunchServiceProvider: Codable {
    let name: String?
}




struct LastEventsModel: Codable {
    let name: String?
    let results: [ResultedEvents]
}

struct ResultedEvents: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let webcastLive: Bool?
    let location: String?
    let videoURL: String?
    let featureImage: String?
    let date: String?
    let launches: [Launch]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case webcastLive = "webcast_live"
        case location
        case videoURL = "video_url"
        case featureImage = "feature_image"
        case date
        case launches
    }
}

struct Launch: Codable {
    let name: String?
    let rocket: Rocket
    let mission: Mission?
    let pad: Pad
}

struct Pad: Codable {
    let name: String?
    let WikiUrl: String?
    let latitude, longitude: String?
    let launchCount: Int?
    let orbitalLaunchCount: Int?
    let agencyID: Int?
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case name
        case WikiUrl = "wiki_url"
        case latitude
        case longitude
        case launchCount = "total_launch_count"
        case orbitalLaunchCount = "orbital_launch_attempt_count"
        case agencyID = "agency_id"
        case location
    }
}

struct Mission: Codable {
    let name, description: String?
}

struct Rocket: Codable {
    let id: Int?
    let configuration: Configuration
}

struct Configuration: Codable {
    let url: String?
    let name: String?
}

struct Location: Codable {
    let name: String?
}

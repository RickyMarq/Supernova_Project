//
//  NewsModel.swift
//  Supernova
//
//  Created by Henrique Marques on 31/01/23.
//

import Foundation

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

struct ResultedNewsSite: Codable {
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

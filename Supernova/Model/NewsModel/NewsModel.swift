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

//
//  ErrorEnum.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 29/01/24.
//

import Foundation

enum NetworkingError: String, Error {
    case badUrl = "Error trying to get data, try again later."
    case decodingError = "Error trying to decode data"
}

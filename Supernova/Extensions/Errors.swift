//
//  Errors.swift
//  Supernova
//
//  Created by Henrique Marques on 07/07/24.
//

import Foundation

enum Errors: String, Error {
    case badUrl = "Error on url"
    case data = "Data not found"
    case decode = "Error trying to decode data"
}

//
//  AboutModel.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import Foundation

struct AboutTableSection {
    let title: String
    let cell: [cellType]
}

enum cellType {
    case staticCell(model: aboutTableModel)
}

struct aboutTableModel {
    let name: String?
    let link: String?
}

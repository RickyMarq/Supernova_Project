//
//  WhatsNewSection.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import Foundation

struct WhatsNewSection {
    let title: String?
    let whatsNewCell: [whatsNewCell]
}

enum whatsNewCell {
    case whatsNewCell(model: WhatsNewCellModel)
}

struct WhatsNewCellModel {
    let version: String
    let infoText: String
    let updateLabel: String
    let actualVersion: Bool
}

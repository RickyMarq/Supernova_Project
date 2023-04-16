//
//  DateExtension.swift
//  Supernova
//
//  Created by Henrique Marques on 15/03/23.
//

import Foundation

extension Date {
    func monthName(month: Int) -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMM")
            return df.string(from: self)
    }
}

enum Month: Int {
    case jan = 1
    case fev = 2
    case march = 3
    case april = 4
    case may = 5
    case june = 6
    case july = 7
    case agoust = 8
    case september = 9
    case october = 10
    case nov = 11
    case dez = 12
}

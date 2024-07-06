//
//  UIColor+Extension.swift
//  Supernova
//
//  Created by Henrique Marques on 18/02/23.
//

import Foundation
import UIKit

extension UIColor {
    
    static let primaryColour = UIColor(red: 132/255, green: 93/255, blue: 194/255, alpha: 1.0)
    
    static let backgroundColour = UIColor(red: 88/255, green: 80/255, blue: 102/255, alpha: 40/255)
    
    static let secondaryColour = UIColor(red: 176/255, green: 159/255, blue: 204/255, alpha: 80/255)
    
    static let testBackgroundColour = UIColor(red: 24/255, green: 25/255, blue: 26/255, alpha: 1.0)
    
    static let tabBarColor = UIColor(red: 14/255, green: 15/255, blue: 16/255, alpha: 1.0)
    
    static let terniaryColour = UIColor(hex: "#61458F")
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

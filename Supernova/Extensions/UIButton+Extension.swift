//
//  UIButton+Extension.swift
//  Supernova
//
//  Created by Henrique Marques on 20/02/23.
//

import Foundation
import UIKit

extension UIButton {
    
    enum ButtonAppearance {
        case primary
    }
    
    func setButtonDesign(layout: ButtonAppearance) {
        
        switch layout {
            case .primary:
            translatesAutoresizingMaskIntoConstraints = false
            tintColor = .white
            backgroundColor = .primaryColour
            layer.borderColor = UIColor.primaryColour.cgColor
            layer.borderWidth = 1
            layer.cornerRadius = 15
            layer.shadowColor = UIColor.primaryColour.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowRadius = 1.5
            layer.shadowOpacity = 1
            layer.masksToBounds = false
            setTitleColor(.white, for: .normal)
        }
        
    }
    
    func setShadowOfButton() {
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
}

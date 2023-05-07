//
//  UIView+Extension.swift
//  Supernova
//
//  Created by Henrique Marques on 05/02/23.
//

import Foundation
import UIKit


extension UIView {
    
    public func setGradientBackground() {
        let gradient = CAGradientLayer()
        let color = UIColor(red: 132/255, green: 94/255, blue: 194/255, alpha: 1.0)
        gradient.colors = [UIColor.black.withAlphaComponent(0.5).cgColor, color.withAlphaComponent(0.5).cgColor]
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: .min)
    }
    
    public func setGradientButtonBackground() {
        let gradient = CAGradientLayer()
//        let color = UIColor(red: 132/255, green: 94/255, blue: 194/255, alpha: 1.0)
        gradient.colors = [UIColor.black.withAlphaComponent(0.5).cgColor, UIColor.secondaryColour.withAlphaComponent(0.5).cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: .min)
    }
    
    public func setGradientImage() {
        let gradient = CAGradientLayer()
        let color = UIColor(red: 40/255, green: 28/255, blue: 63/255, alpha: 1.0)
        gradient.colors = [color.withAlphaComponent(0.0).cgColor, color.withAlphaComponent(0.0).cgColor]
//        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.locations = [0.6, 1.0]
//        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: .min)
    }
    
    public func setGradientBlackImage() {
        let topGradient = CAGradientLayer()
        topGradient.colors = [UIColor.systemBackground.cgColor, UIColor.secondarySystemBackground.withAlphaComponent(0.0).cgColor]
        topGradient.locations = [0.0, 0.2]
        topGradient.frame = self.bounds
        self.layer.insertSublayer(topGradient, at: 0)
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBackground.withAlphaComponent(0.0).cgColor, UIColor.secondarySystemBackground.cgColor]
        gradient.locations = [0.6, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: .min)
    }
    
    public func setShadow(view: UIView) {
        view.layer.cornerRadius = 12.0
        view.layer.borderWidth = 0.0
        view.layer.shadowColor = UIColor.secondaryColour.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 3.5
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
    }
    
    public func setBorder(view: UIView) {
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.secondaryColour.cgColor
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var cornerMask = CACornerMask()
        if(corners.contains(.topLeft)) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if(corners.contains(.topRight)) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if(corners.contains(.bottomLeft)) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if(corners.contains(.bottomRight)) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = cornerMask
    }
    
}

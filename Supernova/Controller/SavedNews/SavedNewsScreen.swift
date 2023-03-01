//
//  SavedNewsScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 02/02/23.
//

import UIKit

class SavedNewsScreen: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SavedNewsScreen: ViewCode {
  
    func configureSubViews() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
        DispatchQueue.main.async {
            self.setGradientBackground()
        }
    }
    
    func configureAccessibility() {
        
    }
    
    
}

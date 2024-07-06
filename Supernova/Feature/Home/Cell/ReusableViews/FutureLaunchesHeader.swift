//
//  FutureLaunchesHeader.swift
//  Supernova
//
//  Created by Henrique Marques on 07/03/23.
//

import UIKit

class FutureLaunchesHeader: UICollectionReusableView {
    
    static let identifier = "FutureLaunchesHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
}

extension FutureLaunchesHeader: ViewCode {
  
    func configureSubViews() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

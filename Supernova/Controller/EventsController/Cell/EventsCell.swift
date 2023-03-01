//
//  EventsCell.swift
//  Supernova
//
//  Created by Henrique Marques on 28/02/23.
//

import UIKit

class EventsCell: UICollectionViewCell {
    
    static let identifier = "EventsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension EventsCell: ViewCode {
  
    func configureSubViews() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

//
//  LauchesScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 12/02/23.
//

import UIKit

class LauchesScreen: UIView {
    
    lazy var lauchNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LauchesScreen: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.lauchNameLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.lauchNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.lauchNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
}

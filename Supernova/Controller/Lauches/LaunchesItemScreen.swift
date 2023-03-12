//
//  LauchesScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 12/02/23.
//

import UIKit

class LaunchesItemScreen: UIView {
    
    lazy var launchNameLabel: UILabel = {
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

extension LaunchesItemScreen: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.launchNameLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.launchNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.launchNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
}

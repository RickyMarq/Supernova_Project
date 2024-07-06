//
//  SettingsFooter.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit

class SettingsFooter: UITableViewHeaderFooterView {

    static let identifier = "SettingsFooter"
    
    lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Made by a human in Brazil 👾"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension SettingsFooter: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.informationLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.informationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.informationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
    
    
}

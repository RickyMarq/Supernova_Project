//
//  TitleReusable.swift
//  Supernova
//
//  Created by Henrique Marques on 02/03/23.
//

import UIKit

class TitleReusable: UICollectionReusableView {
    
    static let identifier = "TitleReusable"
    
    lazy var titleCollectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
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

extension TitleReusable: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.titleCollectionLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.titleCollectionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.titleCollectionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

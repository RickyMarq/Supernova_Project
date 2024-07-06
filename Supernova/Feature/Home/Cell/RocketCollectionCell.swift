//
//  RocketCollectionCell.swift
//  Supernova
//
//  Created by Henrique Marques on 21/06/23.
//

import UIKit

class RocketCollectionCell: UICollectionViewCell {
    
    static let identifier = "RocketCollectionCell"
    
    lazy var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func configCell(with data: SupernovaRocketModel) {
        self.rocketImageView.sd_setImage(with: URL(string: data.image ?? "Error"))
    }
    
}

extension RocketCollectionCell: ViewCode {
    
    func configureSubViews() {
        self.contentView.addSubview(self.rocketImageView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.rocketImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.rocketImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.rocketImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.rocketImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

//
//  LaunchesCell.swift
//  Supernova
//
//  Created by Henrique Marques on 01/03/23.
//

import UIKit

class LaunchesCell: UICollectionViewCell {
    
    static let identifier = "LaunchesCell"
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.roundCorners([.topLeft, .topRight], radius: 12.0)
        return imageView
    }()
    
    lazy var newsNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byWordWrapping
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

extension LaunchesCell: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.newsImageView)
        self.addSubview(self.newsNameLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.newsImageView.heightAnchor.constraint(equalToConstant: 150),
            
            self.newsNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.newsNameLabel.topAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: 14),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.setShadow(view: self)
    }
    
    func configureAccessibility() {
        
    }
    
    
}

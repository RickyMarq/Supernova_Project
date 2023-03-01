//
//  PicturesOfTheDaysCell.swift
//  Supernova
//
//  Created by Henrique Marques on 20/02/23.
//

import UIKit

class PicturesOfTheDaysCell: UICollectionViewCell {
    
    static let identifier = "PicturesOfTheDaysCell"
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var pictureOfTheDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .label
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

extension PicturesOfTheDaysCell: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.newsImageView)
        self.addSubview(self.pictureOfTheDayLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.pictureOfTheDayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            self.pictureOfTheDayLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            self.pictureOfTheDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
        self.setShadow(view: self)
//        self.layer.masksToBounds = true
    }
    
    func configureAccessibility() {
        
    }
    
    
}

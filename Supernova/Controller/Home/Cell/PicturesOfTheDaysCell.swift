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
        imageView.contentMode = .scaleAspectFill
        imageView.roundCorners([.allCorners], radius: 10)
        imageView.layer.masksToBounds = true
 //       imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var pictureOfTheDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var contentViewLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiarySystemBackground.withAlphaComponent(0.50)
        return view
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
        self.contentView.addSubview(self.newsImageView)
        self.contentView.addSubview(self.contentViewLabel)
        self.contentViewLabel.addSubview(self.pictureOfTheDayLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.newsImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.newsImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.newsImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.newsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.contentViewLabel.topAnchor.constraint(equalTo: self.newsImageView.topAnchor),
            self.contentViewLabel.leftAnchor.constraint(equalTo: self.newsImageView.leftAnchor),
            self.contentViewLabel.rightAnchor.constraint(equalTo: self.newsImageView.rightAnchor),
            self.contentViewLabel.widthAnchor.constraint(equalTo: self.newsImageView.widthAnchor),
            
            self.pictureOfTheDayLabel.leftAnchor.constraint(equalTo: self.contentViewLabel.leftAnchor, constant: 12),
            self.pictureOfTheDayLabel.rightAnchor.constraint(equalTo: self.contentViewLabel.rightAnchor, constant: -12),
            self.pictureOfTheDayLabel.topAnchor.constraint(equalTo: self.contentViewLabel.topAnchor, constant: 2),
            self.pictureOfTheDayLabel.bottomAnchor.constraint(equalTo: self.contentViewLabel.bottomAnchor),
//            self.pictureOfTheDayLabel.bottomAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: -12),
            
            
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

//
//  NasaPictureScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 24/01/23.
//

import UIKit

class NasaPictureScreen: UIView {
    
    lazy var pictureOfTheDayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var pictureOfTheDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Nasa Picture of The Day"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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

extension NasaPictureScreen: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.pictureOfTheDayImageView)
        self.addSubview(self.pictureOfTheDayLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.pictureOfTheDayImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            self.pictureOfTheDayImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.pictureOfTheDayImageView.heightAnchor.constraint(equalToConstant: 300),
            
        
            self.pictureOfTheDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.pictureOfTheDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

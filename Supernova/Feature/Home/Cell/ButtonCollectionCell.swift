//
//  ButtonCollectionCell.swift
//  Supernova
//
//  Created by Henrique Marques on 08/02/23.
//

import UIKit

class ButtonCollectionCell: UICollectionViewCell {
    
    static let identifier = "ButtonCollectionCell"
    
    override var isHighlighted: Bool {
        didSet {
            contentView.alpha = isHighlighted ? 0.5 : 1.0
        }
    }
    
    lazy var buttonImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.backgroundColor = .clear
        return image
    }()
    
    lazy var buttonCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    func configCell(with data: HomeButtons) {
        self.buttonCategoryLabel.text = data.title
//        self.buttonImageView.image = UIImage(named: data.image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension ButtonCollectionCell: ViewCode {
    
    func configureSubViews() {
//        self.contentView.addSubview(self.buttonImageView)
        self.contentView.addSubview(self.buttonCategoryLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            
//            self.buttonImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//            self.buttonImageView.heightAnchor.constraint(equalToConstant: 50),
//            self.buttonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
//            self.buttonImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            
            self.buttonCategoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.buttonCategoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            self.buttonCategoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
//        self.backgroundColor = .secondaryColour
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
//        self.clipsToBounds = true
//        self.layer.borderColor = UIColor.darkGray.withAlphaComponent(1.0).cgColor
//        self.layer.borderWidth = 1.0
//        self.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.layer.shadowRadius = 10
//        self.layer.shadowOpacity = 1
        
//        self.setShadow(view: self)
        
        DispatchQueue.main.async {
            self.setGradientButtonBackground()
        }
    }
    
    func configureAccessibility() {
        
    }
    
    
}

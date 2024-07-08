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
        self.contentView.addSubview(self.buttonCategoryLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            self.buttonCategoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.buttonCategoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            self.buttonCategoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        DispatchQueue.main.async {
            self.setGradientButtonBackground()
        }
    }
    
    func configureAccessibility() {
        
    }
    
}

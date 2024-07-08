//
//  ExploreCollectionCell.swift
//  Supernova
//
//  Created by Henrique Marques on 30/01/23.
//

import UIKit
import SkeletonView

class ExploreCollectionCell: UICollectionViewCell {
    
    static let identifier = "ExploreCollectionCell"
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.roundCorners([.allCorners], radius: 10)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var contentImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiarySystemBackground.withAlphaComponent(0.50)
        return view
    }()
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.isSkeletonable = true
        return label
    }()
    
    func configCell(with data: ResultedModel) {
        self.itemImageView.sd_setImage(with: URL(string: data.image ?? "Error"))
        self.itemLabel.text = data.name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ExploreCollectionCell: ViewCode {
   
    func configureSubViews() {
        self.contentView.addSubview(self.itemImageView)
        self.contentView.addSubview(self.contentImageView)
        self.contentImageView.addSubview(self.itemLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            
            self.itemImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.itemImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.itemImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.itemImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.contentImageView.topAnchor.constraint(equalTo: self.itemImageView.topAnchor),
            self.contentImageView.leadingAnchor.constraint(equalTo: self.itemImageView.leadingAnchor),
            self.contentImageView.trailingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor),
            self.contentImageView.widthAnchor.constraint(equalTo: self.itemImageView.widthAnchor),
            
            self.itemLabel.leftAnchor.constraint(equalTo: self.contentImageView.leftAnchor, constant: 12),
            self.itemLabel.rightAnchor.constraint(equalTo: self.contentImageView.rightAnchor, constant: -12),
            self.itemLabel.topAnchor.constraint(equalTo: self.contentImageView.topAnchor, constant: 2),
            self.itemLabel.bottomAnchor.constraint(equalTo: self.contentImageView.bottomAnchor),

            
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.isSkeletonable = true
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    func configureAccessibility() {
        
    }
    
    
}

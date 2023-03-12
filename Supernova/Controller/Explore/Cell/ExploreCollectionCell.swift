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
        imageView.contentMode = .scaleToFill
        imageView.isSkeletonable = true
        return imageView
    }()
    
    lazy var contentImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentViewLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.frame = self.contentViewLabel.bounds
        return gradient
    }()
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Teste"
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
        
        self.contentImageView.addSubview(self.contentViewLabel)
        self.contentViewLabel.addSubview(self.itemLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            
            self.itemImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.itemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.itemImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.itemImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.contentImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.contentViewLabel.topAnchor.constraint(equalTo: self.contentImageView.topAnchor),
//            self.contentViewLabel.bottomAnchor.constraint(equalTo: self.contentImageView.bottomAnchor),
//            self.contentViewLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            self.contentViewLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.contentViewLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
//            self.contentViewLabel.leadingAnchor.constraint(equalTo: self.contentImageView.leadingAnchor),
//            self.contentViewLabel.trailingAnchor.constraint(equalTo: self.contentImageView.trailingAnchor),

            
            self.itemLabel.topAnchor.constraint(equalTo: self.contentViewLabel.topAnchor, constant: 4),
            self.itemLabel.bottomAnchor.constraint(equalTo: self.contentViewLabel.bottomAnchor, constant: -4),
            self.itemLabel.leftAnchor.constraint(equalTo: self.contentViewLabel.leftAnchor, constant: 12),
            self.itemLabel.rightAnchor.constraint(equalTo: self.contentViewLabel.rightAnchor, constant: -12),
            
            
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.isSkeletonable = true
        self.backgroundColor = .secondarySystemBackground
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.darkGray.withAlphaComponent(1.0).cgColor
        self.layer.borderWidth = 1.0    
    }
    
    func configureAccessibility() {
        
    }
    
    
}

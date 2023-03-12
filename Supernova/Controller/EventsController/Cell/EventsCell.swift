//
//  EventsCell.swift
//  Supernova
//
//  Created by Henrique Marques on 28/02/23.
//

import UIKit
import SkeletonView

class EventsCell: UICollectionViewCell {
    
    static let identifier = "EventsCell"
    
    lazy var eventsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var eventsNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 2
        label.skeletonLineSpacing = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var eventsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 2
        label.skeletonLineSpacing = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var eventsDateLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .tertiaryLabel
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

extension EventsCell: ViewCode {
  
    func configureSubViews() {
        self.contentView.addSubview(self.eventsImageView)
        self.contentView.addSubview(self.eventsNameLabel)
        self.contentView.addSubview(self.eventsDescriptionLabel)
        self.contentView.addSubview(self.eventsDateLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
        
            self.eventsNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.eventsNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.eventsNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            self.eventsImageView.topAnchor.constraint(equalTo: self.eventsNameLabel.bottomAnchor, constant: 12),
            self.eventsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.eventsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.eventsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            self.eventsDescriptionLabel.topAnchor.constraint(equalTo: self.eventsImageView.bottomAnchor, constant: 8),
            self.eventsDescriptionLabel.leftAnchor.constraint(equalTo: self.eventsNameLabel.leftAnchor),
            self.eventsDescriptionLabel.rightAnchor.constraint(equalTo: self.eventsNameLabel.rightAnchor),
            self.eventsDescriptionLabel.heightAnchor.constraint(equalToConstant: 80),
            
            self.eventsDateLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            self.eventsDateLabel.leftAnchor.constraint(equalTo: self.eventsDescriptionLabel.leftAnchor),
            self.eventsDateLabel.rightAnchor.constraint(equalTo: self.eventsDescriptionLabel.rightAnchor),
            
            
            
        
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.isSkeletonable = true
        self.backgroundColor = .secondarySystemBackground
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.setShadow(view: self)
    }
    
    func configureAccessibility() {
        
    }
    
    
}

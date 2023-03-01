//
//  NewsTextCell.swift
//  Supernova
//
//  Created by Henrique Marques on 26/02/23.
//

import UIKit
import SkeletonView

class NewsTextCell: UICollectionViewCell {
    
    static let identifier = "NewsTextCell"
    
    lazy var newsNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 2
        label.skeletonLineSpacing = 2.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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

extension NewsTextCell: ViewCode {
   
    func configureSubViews() {
        self.contentView.addSubview(self.newsNameLabel)
        self.contentView.addSubview(self.newsDescriptionLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.newsNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.newsNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.newsNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
    
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
}

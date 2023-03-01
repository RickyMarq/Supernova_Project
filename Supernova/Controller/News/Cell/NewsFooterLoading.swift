//
//  NewsFooterLoading.swift
//  Supernova
//
//  Created by Henrique Marques on 01/02/23.
//

import UIKit

class NewsFooterLoading: UICollectionReusableView {
    
    static let identifier = "NewsFooterLoading"
    
    lazy var loadingMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.text = "Loading more News..."
        return label
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
}

extension NewsFooterLoading: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.loadingMoreLabel)
        self.addSubview(self.activity)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            self.activity.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.activity.heightAnchor.constraint(equalToConstant: 25),
//            self.activity.widthAnchor.constraint(equalToConstant: 50),
            
            self.loadingMoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingMoreLabel.topAnchor.constraint(equalTo: self.activity.bottomAnchor, constant: 4),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .clear
    }
    
    func configureAccessibility() {
        
    }
    
    
}

//
//  NewsFooterLoading.swift
//  Supernova
//
//  Created by Henrique Marques on 01/02/23.
//

import UIKit
import Lottie

class NewsFooterLoading: UICollectionReusableView {
    
    static let identifier = "NewsFooterLoading"
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    lazy var loadingAnimationView: LottieAnimationView = {
        var animationView = LottieAnimationView(name: "loading.json")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.tintColor = .systemPurple
        animationView.play()
        return animationView
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
        self.addSubview(self.loadingAnimationView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([

            self.loadingAnimationView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.loadingAnimationView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            
            self.loadingAnimationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.loadingAnimationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .clear
    }
    
    func configureAccessibility() {
        
    }
    
    
}

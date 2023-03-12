//
//  PageControlFooter.swift
//  Supernova
//
//  Created by Henrique Marques on 20/02/23.
//

import UIKit

class PageControlFooter: UICollectionReusableView {
    
    static let identifier = "PageContPageControlFooterrolFooter"
    
    lazy var homePageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .secondaryColour
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
        pageControl.isAccessibilityElement = false
        pageControl.tag = 1
        pageControl.layer.masksToBounds = true
        pageControl.layer.cornerRadius = 10
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
}

extension PageControlFooter: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.homePageControl)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.homePageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.homePageControl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

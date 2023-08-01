//
//  HomeAdCell.swift
//  Supernova
//
//  Created by Henrique Marques on 31/07/23.
//

import UIKit
import GoogleMobileAds

class HomeAdCell: UICollectionViewCell {
    
    static let identifier = "HomeAdCell"
    
    lazy var adsView: GADBannerView = {
        let ads = GADBannerView()
        ads.contentMode = .scaleToFill
        ads.layer.masksToBounds = true
        ads.layer.cornerRadius = 12
        ads.translatesAutoresizingMaskIntoConstraints = false
        ads.adUnitID = "ca-app-pub-7460518702464601/2402708926"
        return ads
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension HomeAdCell: ViewCode {
    
    func configureSubViews() {
        self.contentView.addSubview(self.adsView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.adsView.topAnchor.constraint(equalTo: self.topAnchor),
            self.adsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.adsView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.adsView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

//
//  AdsCollectionCell.swift
//  Supernova
//
//  Created by Henrique Marques on 25/02/23.
//

import UIKit
import SkeletonView
import GoogleMobileAds

class AdsCollectionCell: UICollectionViewCell {
    
    static let identifier = "AdsCollectionCell"
    
    lazy var adsView: GADBannerView = {
        let ads = GADBannerView()
        ads.contentMode = .scaleToFill
        ads.isSkeletonable = true
        ads.layer.masksToBounds = true
        ads.layer.cornerRadius = 12
        ads.translatesAutoresizingMaskIntoConstraints = false
        ads.adUnitID = "ca-app-pub-3940256099942544/2934735716"
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

extension AdsCollectionCell: ViewCode {
 
    func configureSubViews() {
        self.contentView.addSubview(self.adsView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            self.adsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            self.adsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.adsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.adsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.isSkeletonable = true
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}

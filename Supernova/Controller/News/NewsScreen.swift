//
//  NewsView.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit
import SkeletonView
import GoogleMobileAds

protocol NewsScreenProtocols: AnyObject {
    func pullToRefreshAction()
    func savedButtonAction()
}

class NewsScreen: UIView {
    
    weak var delegate: NewsScreenProtocols?
    var lastUpdated = ""
    func delegate(delegate: NewsScreenProtocols) {
        self.delegate = delegate
    }
    
    lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        layout.scrollDirection = .vertical
//        layout.collectionView?.showsVerticalScrollIndicator = false
        layout.minimumLineSpacing = 12
        collectionView.tag = 1
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        collectionView.isSkeletonable = true
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.register(AdsCollectionCell.self, forCellWithReuseIdentifier: AdsCollectionCell.identifier)
        collectionView.register(NewsFooterLoading.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NewsFooterLoading.identifier)
        return collectionView
    }()
    
    lazy var adCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        layout.scrollDirection = .vertical
//        layout.collectionView?.showsVerticalScrollIndicator = false
        layout.minimumLineSpacing = 12
        collectionView.tag = 2
        collectionView.isSkeletonable = true
        collectionView.register(AdsCollectionCell.self, forCellWithReuseIdentifier: AdsCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var adsView: GADBannerView = {
        let ads = GADBannerView()
        ads.contentMode = .scaleToFill
        ads.isSkeletonable = true
        ads.layer.masksToBounds = true
        ads.layer.cornerRadius = 12
        ads.translatesAutoresizingMaskIntoConstraints = false
        ads.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ads.tag = 2
        ads.frame = CGRect(x: center.x, y: 0, width: 300, height: 300)
        return ads
    }()
    
    lazy var pullToRefresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.addTarget(self, action: #selector(pullToRefreshTriggered), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "\(lastUpdated)")
        return refresh
    }()
    
    lazy var savedNewsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemPurple
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
//        button.addTarget(self, action: #selector(savedButtonTriggered), for: .touchUpInside)
        if #available(iOS 14.0, *) {
            button.showsMenuAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
        return button
    }()
    
    @objc func pullToRefreshTriggered() {
        self.delegate?.pullToRefreshAction()
    }
    
    @objc func savedButtonTriggered() {
        self.delegate?.savedButtonAction()
    }
    
    public func newsCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSouce: UICollectionViewDataSource) {
        self.newsCollectionView.delegate = delegate
        self.newsCollectionView.dataSource = dataSouce
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension NewsScreen: ViewCode {
 
    func configureSubViews() {
        self.addSubview(self.newsCollectionView)
        self.newsCollectionView.addSubview(self.pullToRefresh)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
//            self.activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.activity.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                    
            self.newsCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.newsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.newsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.newsCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
}

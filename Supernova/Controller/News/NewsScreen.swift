//
//  NewsView.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit
import SkeletonView

protocol NewsScreenProtocols: AnyObject {
    func pullToRefreshAction()
    func savedButtonAction()
}

class NewsScreen: UIView {
    
    weak var delegate: NewsScreenProtocols?
    
    func delegate(delegate: NewsScreenProtocols) {
        self.delegate = delegate
    }
    
    lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        layout.scrollDirection = .vertical
        layout.collectionView?.showsVerticalScrollIndicator = false
        layout.minimumLineSpacing = 12
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isSkeletonable = true
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.register(AdsCollectionCell.self, forCellWithReuseIdentifier: AdsCollectionCell.identifier)
        collectionView.register(NewsTextCell.self, forCellWithReuseIdentifier: NewsTextCell.identifier)
        collectionView.register(NewsFooterLoading.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NewsFooterLoading.identifier)
        return collectionView
    }()
    
    lazy var pullToRefresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.addTarget(self, action: #selector(pullToRefreshTriggered), for: .valueChanged)
        return refresh
    }()
    
    lazy var savedNewsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemPurple
        button.setImage(UIImage(systemName: "books.vertical"), for: .normal)
        button.addTarget(self, action: #selector(savedButtonTriggered), for: .touchUpInside)
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

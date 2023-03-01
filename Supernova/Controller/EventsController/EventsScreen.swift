//
//  EventsScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 13/02/23.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol EventsScreenProtocols: AnyObject {
    func pullToRefreshAction()
}

class EventsScreen: UIView {
    
    weak var delegate: EventsScreenProtocols?
    
    func delegate(delegate: EventsScreenProtocols) {
        self.delegate = delegate
    }
    
    lazy var eventsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        layout.scrollDirection = .vertical
        layout.collectionView?.showsVerticalScrollIndicator = false
        layout.minimumLineSpacing = 12
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isSkeletonable = true
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        return collectionView
    }()
    
    public func eventsCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.eventsCollectionView.delegate = delegate
        self.eventsCollectionView.dataSource = dataSource
    }
    
    lazy var pullToRefresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.addTarget(self, action: #selector(pullToRefreshTriggered), for: .valueChanged)
        return refresh
    }()
    
    @objc func pullToRefreshTriggered() {
        self.delegate?.pullToRefreshAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension EventsScreen: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.eventsCollectionView)
        self.eventsCollectionView.addSubview(self.pullToRefresh)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.eventsCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.eventsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.eventsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.eventsCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
    
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}

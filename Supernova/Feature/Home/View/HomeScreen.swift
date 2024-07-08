//
//  HomeScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit
import Lottie
import SkeletonView

class HomeScreen: UIView {
    
    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isSkeletonable = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeCollectionCellImage.self, forCellWithReuseIdentifier: HomeCollectionCellImage.identifier)
        collectionView.register(ButtonCollectionCell.self, forCellWithReuseIdentifier: ButtonCollectionCell.identifier)
        collectionView.register(ExploreCollectionCell.self, forCellWithReuseIdentifier: ExploreCollectionCell.identifier)
        collectionView.register(TitleCollection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier)
        collectionView.register(NewsCollectionCell.self, forCellWithReuseIdentifier: NewsCollectionCell.identifier)
        collectionView.register(PicturesOfTheDaysCell.self, forCellWithReuseIdentifier: PicturesOfTheDaysCell.identifier)
        collectionView.register(EventsCell.self, forCellWithReuseIdentifier: EventsCell.identifier)
        collectionView.register(RocketCollectionCell.self, forCellWithReuseIdentifier: RocketCollectionCell.identifier)
        collectionView.register(LaunchesCell.self, forCellWithReuseIdentifier: LaunchesCell.identifier)
        collectionView.register(UpcomingLaunchCell.self, forCellWithReuseIdentifier: UpcomingLaunchCell.identifier)
        collectionView.register(HomeAdCell.self, forCellWithReuseIdentifier: HomeAdCell.identifier)
        collectionView.register(PageControlFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PageControlFooter.identifier)
        collectionView.register(TitleReusable.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleReusable.identifier)
        return collectionView
    }()
    
    public func homeCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.homeCollectionView.delegate = delegate
        self.homeCollectionView.dataSource = dataSource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension HomeScreen: ViewCode {

    func configureSubViews() {
        self.backgroundColor = .secondarySystemBackground
        self.addSubview(self.homeCollectionView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.homeCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.homeCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.homeCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.homeCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
}

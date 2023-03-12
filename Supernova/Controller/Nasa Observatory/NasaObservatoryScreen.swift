//
//  NasaObservatoryScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 04/03/23.
//

import UIKit
import SkeletonView

class NasaObservatoryScreen: UIView {
    
    var layoutPintrest = PinterestLayout()
    
    lazy var nasaObservatoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutPintrest)
//        collectionView.isSkeletonable = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        layoutPintrest.contentPadding = PinterestLayout.Padding(horizontal: 5, vertical: 5)
        layoutPintrest.cellsPadding = PinterestLayout.Padding(horizontal: 10, vertical: 10)
 //       collectionView.setContentOffset(CGPoint.zero, animated: false)
        layoutPintrest.columnsCount = 2
        collectionView.reloadData()
        collectionView.register(NasaObservatoryCell.self, forCellWithReuseIdentifier: NasaObservatoryCell.identifier)
        return collectionView
    }()
    
    public func nasaObservatoryCVProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.nasaObservatoryCollectionView.delegate = delegate
        self.nasaObservatoryCollectionView.dataSource = dataSource
    }
    
    public func layoutDelegate(delegate: PinterestLayoutDelegate) {
        self.layoutPintrest.delegate = delegate
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension NasaObservatoryScreen: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.nasaObservatoryCollectionView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.nasaObservatoryCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.nasaObservatoryCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.nasaObservatoryCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.nasaObservatoryCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}

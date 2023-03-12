//
//  LaunchesScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 01/03/23.
//

import UIKit
import HMSegmentedControl

protocol LaunchesScreenProtocol: AnyObject {
    func didChangedValue()
}

class LaunchesScreen: UIView {
    
    weak var delegate: LaunchesScreenProtocol?
    
    func delegate(delegate: LaunchesScreenProtocol) {
        self.delegate = delegate
    }

    lazy var segmentedControl: HMSegmentedControl = {
        let segmented = HMSegmentedControl(sectionTitles: ["Future Launches", "Past Launches"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectionIndicatorColor = .primaryColour
        segmented.backgroundColor = .systemBackground
        segmented.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                         NSAttributedString.Key.foregroundColor: UIColor.label]
        segmented.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmented.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100).integral
        segmented.addTarget(self, action: #selector(segmentedControlSelected), for: .valueChanged)
        return segmented
    }()
    
    lazy var LaunchesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .vertical
//        layout.collectionView?.showsVerticalScrollIndicator = false
        layout.minimumLineSpacing = 12
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isSkeletonable = true
//        collectionView.backgroundColor = .systemBackground
        collectionView.register(LaunchesCell.self, forCellWithReuseIdentifier: LaunchesCell.identifier)
        return collectionView
    }()
    
    public func LaunchesCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.LaunchesCollectionView.delegate = delegate
        self.LaunchesCollectionView.dataSource = dataSource
    }
    
    @objc func segmentedControlSelected() {
        self.delegate?.didChangedValue()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension LaunchesScreen: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.segmentedControl)
        self.addSubview(self.LaunchesCollectionView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.segmentedControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 50),
            self.segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.LaunchesCollectionView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor),
            self.LaunchesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.LaunchesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.LaunchesCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}

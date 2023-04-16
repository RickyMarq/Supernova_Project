//
//  OnboardingScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 01/02/23.
//

import UIKit

protocol OnboardingScreenProtocol: AnyObject {
    func skipButtonAction()
    func skipAllButtonAction()
}

class OnboardingScreen: UIView {
    
    weak var delegate: OnboardingScreenProtocol?
    
    func delegate(delegate: OnboardingScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var onboardingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSizeMake(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.indicatorStyle = .default
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        return collectionView
    }()
    
    public func onboardingCollectionProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.onboardingCollection.delegate = delegate
        self.onboardingCollection.dataSource = dataSource
    }
    
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
    
    lazy var skipIntroButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setButtonDesign(layout: .primary)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var skipAllButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(skipAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func skipButtonTapped() {
        self.delegate?.skipButtonAction()
    }
    
    @objc func skipAllButtonTapped() {
        self.delegate?.skipAllButtonAction()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension OnboardingScreen: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.onboardingCollection)
        self.addSubview(self.skipIntroButton)
        self.addSubview(self.homePageControl)
        self.addSubview(self.skipAllButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.onboardingCollection.topAnchor.constraint(equalTo: self.topAnchor),
            self.onboardingCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.onboardingCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.onboardingCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.skipAllButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -5),
            self.skipAllButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            self.skipIntroButton.topAnchor.constraint(equalTo: self.homePageControl.topAnchor, constant: -44),
            self.skipIntroButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.skipIntroButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            self.skipIntroButton.heightAnchor.constraint(equalToConstant: 44),
            
            self.homePageControl.topAnchor.constraint(equalTo: self.onboardingCollection.bottomAnchor, constant: -100),
            self.homePageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.homePageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.homePageControl.heightAnchor.constraint(equalToConstant: 50),
                    
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
//        self.backgroundColor = .backgroundColour
    }
    
    func configureAccessibility() {
        
    }
    
    
}

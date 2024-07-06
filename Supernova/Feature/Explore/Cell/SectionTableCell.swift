//
//  SectionTableCell.swift
//  Supernova
//
//  Created by Henrique Marques on 26/01/23.
//

import UIKit

class SectionTableCell: UITableViewCell {
    
    static let identifier = "SectionTableCell"
    
    lazy var sectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 150)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 150).integral
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(ExploreCollectionCell.self, forCellWithReuseIdentifier: ExploreCollectionCell.identifier)
        return collectionView
    }()
    
    public func sectionCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSouce: UICollectionViewDataSource) {
        self.sectionCollectionView.delegate = delegate
        self.sectionCollectionView.dataSource = dataSouce
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SectionTableCell: ViewCode {
 
    func configureSubViews() {
        self.contentView.addSubview(self.sectionCollectionView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.sectionCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.sectionCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sectionCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sectionCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

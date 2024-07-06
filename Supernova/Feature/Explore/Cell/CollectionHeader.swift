//
//  CollectionHeader.swift
//  Supernova
//
//  Created by Henrique Marques on 26/01/23.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    static let identifier = "TableViewHeader"
    
    lazy var titleCollectionView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Teste Título"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
}

extension TableViewHeader: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.titleCollectionView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.titleCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleCollectionView.heightAnchor.constraint(equalToConstant: 20),
            self.titleCollectionView.widthAnchor.constraint(equalToConstant: 200),
            self.titleCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

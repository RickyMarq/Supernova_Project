//
//  TitleCollection.swift
//  Supernova
//
//  Created by Henrique Marques on 05/02/23.
//

import UIKit

protocol TitleCollectionProtocol: AnyObject {
    func seeAllAction(reusable: TitleCollection)
}

class TitleCollection: UICollectionReusableView {
    
    static let identifier = "TitleCollection"
    
    weak var delegate: TitleCollectionProtocol?

    func delegate(delegate: TitleCollectionProtocol) {
        self.delegate = delegate
    }
    
    lazy var titleCollectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.primaryColour, for: .normal)
        button.setTitle("See more", for: .normal)
        button.addTarget(self, action: #selector(tappedSeeAllButton), for: .touchUpInside)
        return button
    }()
    
    var showSeeAllButton: Bool = true {
        didSet {
            self.seeAllButton.isHidden = !showSeeAllButton
        }
    }
    
    @objc func tappedSeeAllButton(sender: UIButton) {
        self.delegate?.seeAllAction(reusable: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
}

extension TitleCollection: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.titleCollectionLabel)
        self.addSubview(self.seeAllButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.titleCollectionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.titleCollectionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.seeAllButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            self.seeAllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

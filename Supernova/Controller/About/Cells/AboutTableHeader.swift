//
//  AboutTableHeader.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class AboutTableHeader: UITableViewHeaderFooterView {

    static let identifier = "AboutTableHeader"
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "icon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var madeByLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.text = "By: Henrique Marques"
 //       label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Supernova"
        label.font = .systemFont(ofSize: 24, weight: .bold)
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

extension AboutTableHeader: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.logoImageView)
        self.addSubview(self.appNameLabel)
        self.addSubview(self.madeByLabel)
        
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
        
            self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 100),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.madeByLabel.topAnchor.constraint(equalTo: self.appNameLabel.bottomAnchor, constant: 10),
            self.madeByLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.madeByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.madeByLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.appNameLabel.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 10),
            self.appNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.appNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.appNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

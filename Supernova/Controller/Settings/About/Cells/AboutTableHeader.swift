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
    
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Supernova"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var madeByLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.text = "By: Henrique Marques"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryColour
        label.textAlignment = .left
        label.text = String.appVersion
        label.font = .systemFont(ofSize: 14)
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
        self.addSubview(self.versionLabel)
        
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
        
            self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 100),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100),
            
            self.appNameLabel.topAnchor.constraint(equalTo: self.logoImageView.topAnchor, constant: 8),
            self.appNameLabel.leadingAnchor.constraint(equalTo: self.logoImageView.trailingAnchor, constant: 12),
            self.appNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.madeByLabel.topAnchor.constraint(equalTo: self.appNameLabel.bottomAnchor, constant: 4),
            self.madeByLabel.leadingAnchor.constraint(equalTo: self.appNameLabel.leadingAnchor),
            self.madeByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.versionLabel.topAnchor.constraint(equalTo: self.madeByLabel.bottomAnchor, constant: 4),
            self.versionLabel.leadingAnchor.constraint(equalTo: self.madeByLabel.leadingAnchor),
            self.versionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

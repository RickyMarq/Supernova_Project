//
//  WhatsNewCell.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class WhatsNewCell: UITableViewCell {
    
    static let identifier = "WhatsNewCell"
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var updateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryColour
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var infoTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var actualVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .secondaryColour
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Actual Version"
        return label
    }()
    
    func configCell(with data: WhatsNewCellModel) {
        self.versionLabel.text = data.version
        self.updateLabel.text = data.updateLabel
        self.infoTextLabel.text = data.infoText
        
        if data.actualVersion == false {
            self.actualVersionLabel.removeFromSuperview()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension WhatsNewCell: ViewCode {
  
    func configureSubViews() {
        self.contentView.addSubview(self.versionLabel)
//        self.contentView.addSubview(self.separator)
        self.contentView.addSubview(self.updateLabel)
        self.contentView.addSubview(self.infoTextLabel)
        self.contentView.addSubview(self.actualVersionLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.versionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.versionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            
            self.updateLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 12),
            self.updateLabel.leftAnchor.constraint(equalTo: self.versionLabel.leftAnchor),
            
            self.infoTextLabel.topAnchor.constraint(equalTo: self.updateLabel.bottomAnchor, constant: 12),
            self.infoTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.infoTextLabel.leftAnchor.constraint(equalTo: self.versionLabel.leftAnchor),
            self.infoTextLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.actualVersionLabel.centerYAnchor.constraint(equalTo: self.versionLabel.centerYAnchor),
            self.actualVersionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .tertiarySystemBackground
        self.isUserInteractionEnabled = false
    }
    
    func configureAccessibility() {
        
    }
    
    
}

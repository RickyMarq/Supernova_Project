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
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var updateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var infoTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .tertiaryLabel
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
    
    func configCell(with data: WhatsNewCellModel) {
        self.versionLabel.text = data.version
        self.updateLabel.text = data.updateLabel
        self.infoTextLabel.text = data.infoText
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
        self.contentView.addSubview(self.separator)
        self.contentView.addSubview(self.updateLabel)
        self.contentView.addSubview(self.infoTextLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.versionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
//            self.versionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.versionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            
//            self.versionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
//            self.versionLabel.heightAnchor.constraint(equalToConstant: 15),
            
            
            self.separator.topAnchor.constraint(equalTo: self.versionLabel.topAnchor),
            self.separator.leftAnchor.constraint(equalTo: versionLabel.rightAnchor, constant: 12),
            self.separator.heightAnchor.constraint(equalToConstant: 20),
            self.separator.widthAnchor.constraint(equalToConstant: 15),
//
//            self.separator.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
//           self.separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -250),
            
//            self.separator.rightAnchor.constraint(equalTo: self.versionLabel.rightAnchor, constant: -10),
            
            
            self.updateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
//            self.updateLabel.heightAnchor.constraint(equalToConstant: 15),
            self.updateLabel.leftAnchor.constraint(equalTo: self.separator.rightAnchor, constant: 12),
            
            
 //           self.infoTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.infoTextLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 12),
            self.infoTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.infoTextLabel.leftAnchor.constraint(equalTo: self.versionLabel.leftAnchor),
            self.infoTextLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
        self.isUserInteractionEnabled = false
    }
    
    func configureAccessibility() {
        
    }
    
    
}
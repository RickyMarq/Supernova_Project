//
//  InformationTableCell.swift
//  Movies
//
//  Created by Henrique Marques on 11/01/23.
//

import UIKit

class InformationTableCell: UITableViewCell {

    static let identifier = "InformationTableCell"
    
    lazy var iconView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .white
        return icon
    }()
    
    lazy var textCellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    lazy var informationCellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    
    func configCell(with data: InformationCellModel) {
        self.icon.image = data.icon
        self.iconView.backgroundColor = data.iconBackgroundColor
        self.textCellLabel.text = data.title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension InformationTableCell: ViewCode {

    func configureSubViews() {
        self.contentView.addSubview(self.iconView)
        self.iconView.addSubview(self.icon)
        self.contentView.addSubview(self.textCellLabel)
        self.contentView.addSubview(self.informationCellLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.iconView.heightAnchor.constraint(equalToConstant: 32),
            self.iconView.widthAnchor.constraint(equalToConstant: 32),
            
            self.icon.centerYAnchor.constraint(equalTo: self.iconView.centerYAnchor),
            self.icon.centerXAnchor.constraint(equalTo: self.iconView.centerXAnchor),
            self.icon.heightAnchor.constraint(equalToConstant: 20),
            self.icon.widthAnchor.constraint(equalToConstant: 20),
            
            self.textCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.textCellLabel.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 12),
            self.textCellLabel.heightAnchor.constraint(equalToConstant: 20),
            self.textCellLabel.widthAnchor.constraint(equalToConstant: 150),
            
            self.informationCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.informationCellLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            self.informationCellLabel.heightAnchor.constraint(equalToConstant: 20),
            self.informationCellLabel.widthAnchor.constraint(equalToConstant: 50),
        
        
        ])

    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
        self.accessoryType = .disclosureIndicator
    }
    
    func configureAccessibility() {
        
    }
    
    
}

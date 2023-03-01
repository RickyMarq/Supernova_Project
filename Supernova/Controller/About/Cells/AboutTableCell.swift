//
//  AboutTableCell.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class AboutTableCell: UITableViewCell {
    
    static let identifier = "AboutTableCell"
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Teste"
        return label
    }()
    
    func configCell(with data: AboutModel.aboutTableModel) {
        self.aboutLabel.text = data.name
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension AboutTableCell: ViewCode {
 
    func configureSubViews() {
        self.addSubview(self.aboutLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.aboutLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.aboutLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.accessoryType = .disclosureIndicator

    }
    
    func configureAccessibility() {
        
    }
    
    
}

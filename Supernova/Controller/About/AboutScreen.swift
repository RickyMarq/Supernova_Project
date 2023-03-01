//
//  AboutScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class AboutScreen: UIView {
    
    lazy var aboutTableVIew: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AboutTableCell.self, forCellReuseIdentifier: AboutTableCell.identifier)
        tableView.register(AboutTableHeader.self, forHeaderFooterViewReuseIdentifier: AboutTableHeader.identifier)
        return tableView
    }()
    
    public func aboutTableViewProtocols(delegate: UITableViewDelegate, dataSouce: UITableViewDataSource) {
        self.aboutTableVIew.delegate = delegate
        self.aboutTableVIew.dataSource = dataSouce
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension AboutScreen: ViewCode {
 
    func configureSubViews() {
        self.addSubview(self.aboutTableVIew)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
        
            self.aboutTableVIew.topAnchor.constraint(equalTo: self.topAnchor),
            self.aboutTableVIew.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.aboutTableVIew.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.aboutTableVIew.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}

//
//  WhatsNewScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class WhatsNewScreen: UIView {
    
    lazy var whatsNewTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(WhatsNewCell.self, forCellReuseIdentifier: WhatsNewCell.identifier)
        return tableView
    }()
    
    public func whatsNewTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.whatsNewTableView.delegate = delegate
        self.whatsNewTableView.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension WhatsNewScreen: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.whatsNewTableView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.whatsNewTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.whatsNewTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.whatsNewTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.whatsNewTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}

//
//  SettingsScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit

class SettingsScreen: UIView {
    
    lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(InformationTableCell.self, forCellReuseIdentifier: InformationTableCell.identifier)
        tableView.register(StaticTableCell.self, forCellReuseIdentifier: StaticTableCell.identifier)
        tableView.register(SettingsFooter.self, forHeaderFooterViewReuseIdentifier: SettingsFooter.identifier)
        tableView.register(NotificationTableCell.self, forCellReuseIdentifier: NotificationTableCell.identifier)
        return tableView
    }()
    
    
    public func settingsTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.settingsTableView.delegate = delegate
        self.settingsTableView.dataSource = dataSource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SettingsScreen: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.settingsTableView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.settingsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.settingsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.settingsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.settingsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}

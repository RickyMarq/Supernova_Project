//
//  SectionScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 26/01/23.
//

import UIKit

class SectionScreen: UIView {
    
    lazy var sectionTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SectionTableCell.self, forCellReuseIdentifier: SectionTableCell.identifier)
        return tableView
    }()
    
    public func sectionTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.sectionTableView.delegate = delegate
        self.sectionTableView.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension SectionScreen: ViewCode {
 
    func configureSubViews() {
        self.addSubview(self.sectionTableView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
        
            self.sectionTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.sectionTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sectionTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sectionTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        DispatchQueue.main.async {
            self.setGradientBackground()
        }
    }
    
    func configureAccessibility() {
        
    }
    
    
}

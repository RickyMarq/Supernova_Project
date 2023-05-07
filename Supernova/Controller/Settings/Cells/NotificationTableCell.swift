//
//  NotificationTableCell.swift
//  Supernova
//
//  Created by Henrique Marques on 07/04/23.
//

import UIKit

protocol NotificationTableCellProtocols: AnyObject {
    func switcherAction(cell: NotificationTableCell)
}

class NotificationTableCell: UITableViewCell {
    
    weak var delegate: NotificationTableCellProtocols?
    
    func delegate(delegate: NotificationTableCellProtocols) {
        self.delegate = delegate
    }
    
    static let identifier = "UITableViewCell"
    
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
    
    lazy var notificationSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = .primaryColour
        switcher.addTarget(self, action: #selector(notificationSwitcherTapped), for: .valueChanged)
        return switcher
    }()
    
    @objc func notificationSwitcherTapped(sender: UISwitch) {
        self.delegate?.switcherAction(cell: self)
    }
    
    func configCell(with data: NotificationModel) {
        self.icon.image = data.icon
        self.iconView.backgroundColor = data.iconBackgroundColor
        self.textCellLabel.text = data.title
//        self.notificationSwitcher.isOn = UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension NotificationTableCell: ViewCode {
    
    func configureSubViews() {
        self.contentView.addSubview(self.iconView)
        self.iconView.addSubview(self.icon)
        self.contentView.addSubview(self.textCellLabel)
        self.contentView.addSubview(self.notificationSwitcher)
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
            self.textCellLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        
            self.notificationSwitcher.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.notificationSwitcher.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}

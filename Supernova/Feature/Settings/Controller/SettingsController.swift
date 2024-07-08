//
//  SettingsController.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit
import SafariServices
import UserNotifications

class SettingsController: UIViewController {
    
    var settingsScreen: SettingsScreen?
    var settingsModel = SettingsModel().populateModel()
    var isEnabled: Bool = false
    var settingsViewModel: SettingsViewModel?
    
    override func loadView() {
        self.settingsScreen = SettingsScreen()
        self.view = settingsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsViewModel = SettingsViewModel(delegate: self)
        self.settingsScreen?.settingsTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpNavigationController()
        UserDefaults.standard.synchronize()
        let isOn = UserDefaults.standard.bool(forKey: "PermissionForNotification")

        DispatchQueue.main.async {
            self.isEnabled = isOn
            self.settingsScreen?.settingsTableView.reloadData()
        }
    }
    
    func setUpNavigationController() {
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .primaryColour
    }
    
    func presentWhatsNew() {
        let vc = WhatsNewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentAboutTheApp() {
        let vc = AboutController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestNotificationAuthorization() {
        
        let nc = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        nc.requestAuthorization(options: options) { granted, _ in
            
            UNUserNotificationCenter.current().getNotificationSettings { result in
                
                switch result.authorizationStatus {
                    
                case .notDetermined:
                    if granted {
                        print("\(#function) Permission granted: \(granted)")
                        self.isEnabled = granted
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                        UserDefaults.standard.set(true, forKey: "PermissionForNotification")
                        UserDefaults.standard.synchronize()
                    } else {
                        self.isEnabled = granted
                        UserDefaults.standard.set(false, forKey: "PermissionForNotification")
                        UserDefaults.standard.synchronize()
                    }
                case .authorized:
                    self.isEnabled = true
                    UserDefaults.standard.set(true, forKey: "PermissionForNotification")
                    UserDefaults.standard.synchronize()
                case .denied:
                    UserDefaults.standard.set(false, forKey: "PermissionForNotification")
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            DispatchQueue.main.async {
                                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                    print("Settings opened: \(success)")
                                })
                            }
                        }
                    }
                case .ephemeral:
                    print("Ephemeral")
                case .provisional:
                    print("Provisional")
                @unknown default:
                    fatalError("Fatal Error")
                }
            }
            }
        }
    }

extension SettingsController: SettingsViewModelProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.settingsScreen?.settingsTableView.reloadData()
        }
    }
    
    func error(message: String) {
        print(message)
    }
}


extension SettingsController: NotificationTableCellProtocols {
    
    func switcherAction(cell: NotificationTableCell) {
        if cell.notificationSwitcher.isOn {
            self.requestNotificationAuthorization()
        } else {
            UIApplication.shared.unregisterForRemoteNotifications()
            UserDefaults.standard.set(false, forKey: "PermissionForNotification")
            UserDefaults.standard.synchronize()
            cell.notificationSwitcher.isOn = false
        }
    }
    
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel?.rowsInSection(section: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsViewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsViewModel?.titleForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = settingsViewModel?.cellRowBySection(indexPath: indexPath)
        
        switch index {
        
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        
        case .informationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableCell.identifier, for: indexPath) as? InformationTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case .WhatsNew(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configWhatsCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        case .documentationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configDocumentationCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case .notificationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableCell.identifier, for: indexPath) as? NotificationTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            cell.delegate(delegate: self)
            cell.notificationSwitcher.isOn = isEnabled
            cell.backgroundColor = .tertiarySystemBackground
              return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = settingsModel[indexPath.section].cell[indexPath.row]
        
        switch index {
            
        case .staticCell(model: let model):
            let doubleHeader = model.title
            model.handler(doubleHeader)
        case .informationCell(model: ):
            self.presentAboutTheApp()
        case .WhatsNew(model:):
            self.presentWhatsNew()
        case .notificationCell(model:):
            print("Change State")
            
        case .documentationCell(model: let model):
            
            self.openSafariPageWith(url: model.link)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 4 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsFooter.identifier) as? SettingsFooter
            return footer
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4 {
            return 50
        } else {
            return 10
        }
    }
}

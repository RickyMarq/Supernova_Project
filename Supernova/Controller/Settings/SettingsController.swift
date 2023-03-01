//
//  SettingsController.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit
import SafariServices

class SettingsController: UIViewController {
    
    var settingsScreen: SettingsScreen?
    var settingsModel = SettingsModel().populateModel()
    
    override func loadView() {
        self.settingsScreen = SettingsScreen()
        self.view = settingsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsScreen?.settingsTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpNavigationController()
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


}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel[section].cell.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsModel.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsModel[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = settingsModel[indexPath.section].cell[indexPath.row]
        
        switch index {
        
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            return cell
        
        case .informationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableCell.identifier, for: indexPath) as? InformationTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            return cell
            
        case .WhatsNew(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configWhatsCell(with: model)
            return cell
        case .documentationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configDocumentationCell(with: model)
            return cell
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
            
        case .documentationCell(model: let model):
            
            self.openSafariPageWith(url: model.link)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsFooter.identifier) as? SettingsFooter
            return footer
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 50
        } else {
            return 10
        }
    }
}

//
//  SettingsViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 07/08/23.
//

import Foundation

protocol SettingsViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class SettingsViewModel {
    
    var settingsModel = SettingsModel().populateModel()
    weak var delegate: SettingsViewModelProtocol?
    
    init(delegate: SettingsViewModelProtocol? = nil) {
        self.delegate = delegate
    }
    
    var numberOfSections: Int {
        return settingsModel.count
    }
    
    func rowsInSection(section: Int) -> Int {
        return settingsModel[section].cell.count
    }
    
    func titleForSection(section: Int) -> String {
        return settingsModel[section].title ?? ""
    }
            
    func cellRowBySection(indexPath: IndexPath) -> CellType {
        return settingsModel[indexPath.section].cell[indexPath.row]
    }
}

//
//  SettingsModel.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import Foundation
import UIKit

class SettingsModel {
    
    var model = [Section]()
    
    func openLinkedin() {
        UIApplication.shared.open(URL(string: "https://linkedin.com/in/henrique-marques0606")!)
    }
    
    func openGithub() {
        UIApplication.shared.open(URL(string: "https://github.com/RickyMarq")!)
    }
    
    func populateModel() -> [Section] {
        
        model.append(Section(title: "Notifications", cell: [
            
            .notificationCell(model: NotificationModel(title: "Notification", icon: UIImage(systemName: "bell.fill") ?? UIImage(), iconBackgroundColor: .systemRed, isOn: false) { doubleHeader in } ),
                                                            
        ]))
                                                            
                                                            
        model.append(Section(title: "Updates", cell: [
        
        
            .WhatsNew(model: WhatsNewModelType(title: "What's New", icon: UIImage(systemName: "sparkles.rectangle.stack") ?? UIImage(), iconBackgroundColor: .systemPurple) { doubleHeader in } ),
        
        ]))
        
        model.append(Section(title: "Social Medias", cell: [
        
        
            .staticCell(model: StaticCellModel(title: "Linkedin", icon: UIImage(systemName: "link") ?? UIImage(), iconBackgroundColor: .darkGray)  { [self] doubleHeader in openLinkedin() } ),
        
            .staticCell(model: StaticCellModel(title: "Github", icon: UIImage(systemName: "link") ?? UIImage(), iconBackgroundColor: .darkGray)  { [self] doubleHeader in openGithub() } ),
        
        ]))
        
        
        model.append(Section(title: "Documentation", cell: [
        
            
            .documentationCell(model: DocumentationCellModel(title: "Terms & Conditions", icon: UIImage(systemName: "doc") ?? UIImage(), iconBackgroundColor: .systemIndigo, link: "https://doc-hosting.flycricket.io/supernova-terms-of-use/648a701f-e928-41b7-9303-d67dbc2c13c8/terms") { doubleHeader in } ),
                
                .documentationCell(model: DocumentationCellModel(title: "Privacy Police", icon: UIImage(systemName: "doc") ?? UIImage(), iconBackgroundColor: .systemIndigo, link: "https://doc-hosting.flycricket.io/supernova-privacy-policy/55231668-fdc6-41f6-9c5c-cbfab49b143f/privacy") { doubleHeader in } ),
                
        
        ]))
        
        model.append(Section(title: "More informations", cell: [
        
                    
            .informationCell(model: InformationCellModel(title: "About the App", icon: UIImage(systemName: "gear") ?? UIImage(), iconBackgroundColor: .systemRed, infoText: "0.1.0") { doubleHeader in } ),
            
         
        ]))
        
        
        return model
    }
}

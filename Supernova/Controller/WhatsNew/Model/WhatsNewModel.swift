//
//  WhatsNewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import Foundation
import UIKit

class WhatsNewModel {
    
    var model = [WhatsNewSection]()
    
    func populate() -> [WhatsNewSection] {
        
        model.append(WhatsNewSection(title: "March 2, 2023", whatsNewCell: [
            
            .whatsNewCell(model: WhatsNewCellModel(version: "0.2.0", infoText: "- Hey, this is a test to see if the table view cell grow as text inside this label. \n \n  - Hey, this is a test to see if the table view cell grow as text inside this label \n \n  - Hey, this is a test to see if the table view cell grow as text inside this label ", updateLabel: "Release"))
        
        ]))
        
        model.append(WhatsNewSection(title: "February 20, 2023", whatsNewCell: [
        
            
            .whatsNewCell(model: WhatsNewCellModel(version: "0.1.1", infoText: "- Fixed a bug when tapped a home cell", updateLabel: "Bug Fix"))
        
        ]))
        
        
        model.append(WhatsNewSection(title: "February 10, 2023", whatsNewCell: [
        
        
            .whatsNewCell(model: WhatsNewCellModel(version: "0.1.0", infoText: "- Supernova is now available on TestFlight for testing.", updateLabel: "Release Notes"))
        
        ]))


        return model
    }
    
}

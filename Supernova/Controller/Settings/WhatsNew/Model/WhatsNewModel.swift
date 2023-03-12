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
        
        model.append(WhatsNewSection(title: "March 15, 2023", whatsNewCell: [
        
            .whatsNewCell(model: WhatsNewCellModel(version: "0.1.0", infoText: "Supernova is finally available on TestFlight, good testing for all", updateLabel: "Release"))
        
        ]))
        
        model.append(WhatsNewSection(title: "March 20, 2023", whatsNewCell: [
            
            .whatsNewCell(model: WhatsNewCellModel(version: "0.2.0", infoText: "- Hey, this is a test to see if the table view cell grow as text inside this label. \n \n  - Hey, this is a test to see if the table view cell grow as text inside this label \n \n  - Hey, this is a test to see if the table view cell grow as text inside this label ", updateLabel: "Release"))
        
        ]))
        
        return model
    }
}

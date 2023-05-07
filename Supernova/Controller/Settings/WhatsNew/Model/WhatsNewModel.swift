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
        
        model.append(WhatsNewSection(title: "May 05, 2023", whatsNewCell: [
        
            .whatsNewCell(model: WhatsNewCellModel(version: "\(String.appVersion)", infoText: "• Fixed the following bugs: \n \n - App crashes on iOS 14 & 15 \n \n - Last News crashes when a date wasn't provided", updateLabel: "Bug Fixes", actualVersion: true))
        
        ]))

    
        model.append(WhatsNewSection(title: "May 04, 2023", whatsNewCell: [
        
            .whatsNewCell(model: WhatsNewCellModel(version: "1.0.0", infoText: "• Supernova is finally available on TestFlight, good testing for all", updateLabel: "Release Notes", actualVersion: false))
        
        ]))
        

        return model
    }
}

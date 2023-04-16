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
        
        model.append(WhatsNewSection(title: "April 15, 2023", whatsNewCell: [
        
            .whatsNewCell(model: WhatsNewCellModel(version: "0.1.0", infoText: "• Supernova is finally available on TestFlight, good testing for all", updateLabel: "Release Notes"))
        
        ]))
        

        return model
    }
}

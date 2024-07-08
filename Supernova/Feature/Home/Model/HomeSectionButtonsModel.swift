//
//  HomeSectionButtonsModel.swift
//  Supernova
//
//  Created by Henrique Marques on 08/02/23.
//

import Foundation

struct HomeButtons {
    let title: String
}

class HomeSectionButtonsModel {
    
    var model = [HomeButtons]()
        
    func populateModel() -> [HomeButtons] {
        
        model.append(contentsOf: [HomeButtons(title: "Launches"),
                                 HomeButtons(title: "Last News"),
                                 HomeButtons(title: "Spacial Events"),
                                 HomeButtons(title: "Nasa Observatory")])
        
        return model
        
    }    
}


//
//  HomeSectionButtonsModel.swift
//  Supernova
//
//  Created by Henrique Marques on 08/02/23.
//

import Foundation

struct HomeButtons {
    let image: String
    let title: String
}

class HomeSectionButtonsModel {
    
    var model = [HomeButtons]()
        
    func populateModel() -> [HomeButtons] {
        
        model.append(contentsOf: [HomeButtons(image: "rocket", title: "Launches"),
                                 HomeButtons(image: "", title: "Last News"),
                                 HomeButtons(image: "", title: "Spacial Events"),
                                 HomeButtons(image: "", title: "Nasa Observatory")])
        
        return model
        
        
    }
    
}


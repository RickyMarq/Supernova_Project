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
        
        
        model.append(contentsOf: [HomeButtons(image: "falcon.png", title: "Lauches"),
                                 HomeButtons(image: "", title: "News"),
                                 HomeButtons(image: "", title: "Spacial Events"),
                                 HomeButtons(image: "", title: "Crews")])
        
        return model
        
        
    }
    
}

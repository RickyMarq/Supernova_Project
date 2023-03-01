//
//  AboutModel.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import Foundation

class AboutModel {
    
    struct AboutTableSection {
        let title: String
        let cell: [cellType]
    }
    
    enum cellType {
        case staticCell(model: aboutTableModel)
    }
    
    struct aboutTableModel {
        let name: String?
        let link: String?
    }
    
    var model = [AboutTableSection]()
    
    func populateModel() -> [AboutTableSection] {
        
        model.append(AboutTableSection(title: "A Huge thanks to all my friends", cell: [
            
            .staticCell(model: aboutTableModel(name: "Wesley Calazans", link: "https://google.com")),
            
        ]))
        
        model.append(AboutTableSection(title: "And for all of the creators of this libraries", cell: [
            
            
            .staticCell(model: aboutTableModel(name: "SDWebImage", link: "")),
            .staticCell(model: aboutTableModel(name: "Lottie", link: "")),
            .staticCell(model: aboutTableModel(name: "SkeletonView", link: ""))
            
            
        ]))
        
        return model
        
    }
    
}

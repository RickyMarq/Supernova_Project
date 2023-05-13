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
        
        model.append(AboutTableSection(title: "A Huge thanks to all my friends & Teachers", cell: [
            
            .staticCell(model: aboutTableModel(name: "Wesley Calazans - App", link: "https://apps.apple.com/br/app/bevegan-produtos-veganos/id1634230135?l=en")),
            
            .staticCell(model: aboutTableModel(name: "Felipe Miranda - iOS Development", link: "https://www.youtube.com/@BackFrontAcademy")),
            
            .staticCell(model: aboutTableModel(name: "Caio Fabrini - iOS Developer", link: "https://www.linkedin.com/in/caio-fabrini-0314861b6/")),
            
            .staticCell(model: aboutTableModel(name: "Marcelo Costa - iOS Developer", link: "https://www.linkedin.com/in/marcelo-g-costa-br/")),
            
            .staticCell(model: aboutTableModel(name: "Moacir Lamego - iOS Developer", link: "https://www.linkedin.com/in/moacirlamego/")),
            
            
        ]))
        
        model.append(AboutTableSection(title: "And for all of the creators of this libraries", cell: [
            
            
            .staticCell(model: aboutTableModel(name: "SDWebImage", link: "https://github.com/SDWebImage/SDWebImage")),
            .staticCell(model: aboutTableModel(name: "Lottie", link: "https://github.com/airbnb/lottie-ios")),
            .staticCell(model: aboutTableModel(name: "SkeletonView", link: "https://github.com/Juanpe/SkeletonView"))
            
            
        ]))
        
//        model.append(AboutTableSection(title: "And thanks for the illustrators", cell: [
//
//
//            .staticCell(model: aboutTableModel(name: "TODO: Name of illustrators of onboarding", link: "https://google.com"))
//
//
//        ]))
        
        return model
        
    }
    
}

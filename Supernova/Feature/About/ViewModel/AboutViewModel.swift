//
//  AboutViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 19/08/23.
//

import Foundation

protocol AboutViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class AboutViewModel {
    
    var model: [AboutTableSection] = []
    weak var delegate: AboutViewModelProtocol?
        
    init(delegate: AboutViewModelProtocol? = nil) {
        self.delegate = delegate
    }
    
    func populateModel() {
        
        model.append(AboutTableSection(title: "A Huge thanks to all my friends & Teachers", cell: [
            
            .staticCell(model: aboutTableModel(name: "Amanda Ferreira", link: "https://www.instagram.com/amandarocha_274/?next=%2Famanddarochaoficial%2F")),
            
            .staticCell(model: aboutTableModel(name: "Wesley Calazans - App", link: "https://apps.apple.com/br/app/bevegan-produtos-veganos/id1634230135?l=en")),
            
            .staticCell(model: aboutTableModel(name: "Felipe Miranda - iOS Development", link: "https://www.youtube.com/@BackFrontAcademy")),
            
            .staticCell(model: aboutTableModel(name: "Caio Fabrini - iOS Developer", link: "https://www.linkedin.com/in/caio-fabrini-0314861b6/")),
            
            .staticCell(model: aboutTableModel(name: "Marcelo Costa - iOS Developer", link: "https://www.linkedin.com/in/marcelo-g-costa-br/")),
            
        ]))
        
        model.append(AboutTableSection(title: "And for all of the creators of this libraries", cell: [
            
            .staticCell(model: aboutTableModel(name: "SDWebImage", link: "https://github.com/SDWebImage/SDWebImage")),
            .staticCell(model: aboutTableModel(name: "Lottie", link: "https://github.com/airbnb/lottie-ios")),
            .staticCell(model: aboutTableModel(name: "SkeletonView", link: "https://github.com/Juanpe/SkeletonView"))
            
            
        ]))
            
//        return model
    }
    
    var countModel: Int {
        return model.count
    }
    
    func modelSection(section: Int) -> Int {
        return model[section].cell.count
    }
    
    func modelTitles(section: Int) -> String {
        return model[section].title
    }
    
    func cellCount(section: Int, indexPath: IndexPath) -> cellType {
        return model[section].cell[indexPath.row]
    }
    
    func indexPath(indexPath: IndexPath) -> AboutTableSection {
        return model[indexPath.row]
    }
}

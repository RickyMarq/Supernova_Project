//
//  ImageViewerViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 08/08/23.
//

import Foundation

class ImageViewerViewModel {
    
    var data: PictureOfTheDay?
    
    init(data: PictureOfTheDay? = nil) {
        self.data = data
    }
    
    var getPictureOfTheDay: String {
        return data?.url ?? ""
    }
    
    var imageName: String {
        return data?.title ?? ""
    }
    
    var imageExplanation: String {
        return data?.explanation ?? ""
    }
}

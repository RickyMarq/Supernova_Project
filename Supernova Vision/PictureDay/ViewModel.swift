//
//  ViewModel.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 26/01/24.
//

import SwiftUI

@Observable
class ViewModel {
    var titleText: String = ""
    var isTitleFinished: Bool = false
    var finalTitle: String = "Hello World"
    
    // Picture of the Day
    
    var isShowingInfo: Bool = false
    var infoTitle: String = "Show info"

}

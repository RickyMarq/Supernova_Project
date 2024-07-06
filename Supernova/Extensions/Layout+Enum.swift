//
//  Layout+Enum.swift
//  Supernova
//
//  Created by Henrique Marques on 05/02/23.
//

import Foundation
import UIKit

enum LayoutType {
    case LastLauchesLayout
    case ImageViewer
    case future
    case tableLayout
    case largeButtonsLayout
    case pictureOfTheDay
    case newsLayout
    case adLayout
    case newsTextLayout
    case NextLaunchSection
    case rocketLayout
    case adView
    
    
    func getLayout(withHeader: Bool = true) -> NSCollectionLayoutSection {
        
        switch self {
        case .LastLauchesLayout:
            return AppLayout.sharedObjc.LastLauchesLayout(withHeader: withHeader)
            
        case .future:
            return AppLayout.sharedObjc.futureLauches(withHeader: withHeader)
            
        case .ImageViewer:
            return AppLayout.sharedObjc.ImageViewer()
            
        case .tableLayout:
            return AppLayout.sharedObjc.tableLayout(withHeader: withHeader)
            
        case .largeButtonsLayout:
            return AppLayout.sharedObjc.largeButton(withHeader: withHeader, seeAllButton: false)
            
        case .pictureOfTheDay:
            return AppLayout.sharedObjc.pictureOfTheDay(withHeader: withHeader, withFooter: true)
            
        case .newsLayout:
            return AppLayout.sharedObjc.newsLayout()
            
        case .adLayout:
            return AppLayout.sharedObjc.adLayout()
            
        case .newsTextLayout:
            return AppLayout.sharedObjc.newsTextLayout()
            
        case .NextLaunchSection:
            return AppLayout.sharedObjc.NextLaunchSection()
            
        case .rocketLayout:
            return AppLayout.sharedObjc.rocketLayout(withHeader: true)
        case .adView:
            return AppLayout.sharedObjc.adView()
        }
    }
}

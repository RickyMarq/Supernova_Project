//
//  SupernovaWidgetsBundle.swift
//  SupernovaWidgets
//
//  Created by Henrique Marques on 08/06/23.
//

import WidgetKit
import SwiftUI

@main
struct SupernovaWidgetsBundle: WidgetBundle {
    var body: some Widget {
        WidgetBundleHome().body
        
    }
}

struct WidgetBundleHome: WidgetBundle {
    var body: some Widget {
        SupernovaWidgets()
        PictureOfTheDayWidget()
    }
}

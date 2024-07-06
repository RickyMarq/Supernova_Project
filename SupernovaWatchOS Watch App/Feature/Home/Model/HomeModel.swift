//
//  HomeModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

struct HomeData: Identifiable {
    var id = UUID()
    let name: String?
    let symbol: String?
    let img: String?
    let Screen: AnyView
}


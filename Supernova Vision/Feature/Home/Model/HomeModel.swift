//
//  HomeModel.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 07/07/24.
//

import Foundation
import SwiftUI

struct itemsModel: Identifiable {
    var id = UUID()
    let name: String
    let icon: String
    let view: AnyView?
    var children: [itemsModel]?
}

struct ChildrenData: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
}

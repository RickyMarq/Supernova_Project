//
//  HomeLaunchActivity.swift
//  Supernova
//
//  Created by Henrique Marques on 06/07/24.
//

import Foundation
import SwiftUI
import ActivityKit

struct HomeLaunchActivity: ActivityAttributes {
    
    struct ContentState: Codable, Hashable {
        
    }
    
    var minutesLeft: Double
    var rocketName: String
}

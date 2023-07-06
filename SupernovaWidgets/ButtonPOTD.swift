//
//  ButtonPOTD.swift
//  SupernovaWidgetsExtension
//
//  Created by Henrique Marques on 13/06/23.
//

import SwiftUI
import AppIntents

struct ButtonPOTD: AppIntent {
    
    @available(iOSApplicationExtension 16, *)
    static let title: LocalizedStringResource = "Button"
       
    @available(iOSApplicationExtension 16.0, *)
    func perform() async throws -> some IntentResult {
        print("DEBUG")
        return .result()
    }
}

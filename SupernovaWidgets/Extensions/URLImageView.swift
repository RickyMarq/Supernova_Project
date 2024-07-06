//
//  URLImageView.swift
//  SupernovaWidgetsExtension
//
//  Created by Henrique Marques on 12/06/23.
//

import SwiftUI

struct URLImageView: View {
    let data: Data
    
    var body: some View {
        if let uiimage = UIImage(data: data)!.resized(toWidth: 600) {
            Image(uiImage: uiimage)
                .resizable()
        } else {
            Image(uiImage: UIImage(named: "backgroundLaunching")?.resized(toWidth: 600) ?? UIImage())
                .resizable()
        }
    }
}

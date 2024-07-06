//
//  OpeningView.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 26/01/24.
//

import SwiftUI

struct OpeningView: View {
    @Environment(ViewModel.self) private var model

    var isTitleFinished: Bool = false
    var titleText: String = ""

    
    var body: some View {
        @Bindable var model = model
        
        VStack {
            Image("SunSliver")
                .opacity(0.5)
            
            Spacer(minLength: 120)
            
            VStack {
            
                TitleText(title: model.finalTitle)
                    .padding()
                    .hidden()
                    .overlay(alignment: .leading) {
                        TitleText(title: model.titleText)
                            .padding()
                    }
                
                Text("Where lies a compedium of our universe, explore by accessing the sidebar menu")
                    .monospaced()
                    .font(.title2)
                    .opacity(model.isTitleFinished ? 1 : 0)
            }
            
            Spacer()

        }
        .padding(.bottom, 50)
        .typeText(text: $model.titleText, finalText: "Supernova", isFinished: $model.isTitleFinished, isAnimated: !isTitleFinished)
        .background() {
            Image("EarthHalf")
           //     .resizable()
           //     .scaledToFill()
                .opacity(model.isTitleFinished ? 1 : 0)

        }
        .animation(.default.speed(0.25), value: model.isTitleFinished)
    }
}

struct TitleText: View {
    var title: String
    var body: some View {
        Text(title)
            .monospaced()
            .font(.system(size: 50, weight: .semibold))
    }
}

#Preview {
    OpeningView()
}

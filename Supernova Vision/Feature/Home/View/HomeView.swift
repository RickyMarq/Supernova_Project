//
//  ContentView.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 07/11/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    
    // Erase
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(ViewModel.self) private var model
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @State var fullText = "Welcome to Supernova"
    @State var emptyText = ""
        
    var body: some View {
        @Bindable var model = model
        
        NavigationStack {
            VStack {
                Image("SunSliver")
                    .opacity(0.5)
                
                Spacer(minLength: 120)
                
                VStack {
                    
                    TitleText(title: model.finalTitle)
                        .padding(.horizontal, 10)
                        .hidden()
                        .overlay(alignment: .leading) {
                            TitleText(title: model.titleText)
                                .padding(.horizontal, 10)
                        }
                    
                    Text("Where lies a compedium of our universe, explore by accessing the bottom menu")
                        .padding()
                        .monospaced()
                        .font(.title2)
                        .opacity(model.isTitleFinished ? 1 : 0)
                }
                
                Spacer()
                
            }
            .padding(.bottom, 50)
            .typeText(text: $model.titleText, finalText: "Supernova", isFinished: $model.isTitleFinished, isAnimated: !model.isTitleFinished)
            .background() {
                Image("EarthHalf")
                    .opacity(model.isTitleFinished ? 1 : 0)
                
            }
            .animation(.default.speed(0.25), value: model.isTitleFinished)
            .hoverEffect(.automatic, isEnabled: true)

            .toolbar {
                ToolbarItemGroup(placement: .bottomOrnament) {
                    HStack {
                        NavigationLink(destination: PictureDay()) {
                            Text("Picture of The Day")
                                .bold()
                                .padding()
                        }
                        
                        NavigationLink(destination: UpcomingLaunches()) {
                            Text("Upcoming Launches")
                                .bold()
                                .padding()
                        }
                        
                        
                        NavigationLink(destination: NasaObservatory()) {
                            Text("Nasa Observatory")
                                .bold()
                                .padding()
                        }
                    }
                }
            }
        }
    }
    
    private var typingTimer: Timer {
        
          Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
              guard !self.fullText.isEmpty else {
                  timer.invalidate()
                  return
              }

              let nextCharacter = self.fullText.removeFirst()
              self.emptyText += String(nextCharacter)

              if self.fullText.isEmpty {
                  timer.invalidate()
              }
          }
      }
}
#Preview(windowStyle: .automatic) {
    HomeView()
}

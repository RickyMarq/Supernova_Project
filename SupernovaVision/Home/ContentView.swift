//
//  ContentView.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 07/11/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    // Erase
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    //
    
    @Environment(ViewModel.self) private var model
    @State var data = [
        itemsModel(name: "Rocket Launches", icon: "sparkles", view: AnyView(Launch()), children: [itemsModel(name: "Upcoming Launches", icon: "fireworks", view: AnyView(UpcomingLaunches())), itemsModel(name: "Past Launches", icon: "house", view: AnyView(UpcomingLaunches()))]),
        itemsModel(name: "Picture of the day", icon: "photo.on.rectangle", view: AnyView(PictureDay(pictureOfTheDay: PictureOfTheDay(date: "", explanation: "", title: "", url: "")))),
        itemsModel(name: "Nasa Observatory", icon: "moon.haze", view: AnyView(NasaObservatory()))
    ]
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @State var fullText = "Welcome to Supernova"
    @State var emptyText = ""
        
    var body: some View {
        @Bindable var model = model

        
//        NavigationSplitView {
//            List (data, children: \.children) { datum in
//                    NavigationLink(destination: datum.view) {
//                        Label(datum.name, systemImage: datum.icon)
//                            .foregroundStyle(.primary)
//
//                }
//            } .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    VStack(alignment: .leading) {
//                        Text("Menu")
//                            .font(.largeTitle)
//                        
//                        Text("Supernova")
//                            .foregroundStyle(.tertiary)
//                        
//                        Button(action: {
//                                
//                                Task {
//                                    await self.openImmersiveSpace(id: "ImmersiveRocketSpace")
//                                }
//                                
//                            }) {
//                                Image(systemName: "view.3d")
//                                    .font(.title)
//                                    .frame(width: 44, height: 44)
//                                }
//                            
//                    }
//                }
//            }
            
 //       } detail: {
//            VStack {
//                Spacer()
//                Text(emptyText)
//                    .monospaced()
//                    .font(.largeTitle)
//                    .multilineTextAlignment(.center)
//                    .onAppear {
//                        _ = self.typingTimer
//                    }
//                
//                Model3D(named: "Earth") { model in
//                    model
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 200, height: 200)
//                } placeholder: {
//                    ProgressView()
//                }
//                .padding()
//                 
//                Text("Where lies a compedium of our universe, explore by accessing the sidebar menu")
//                    .monospaced()
//                    .font(.headline)
//                    .multilineTextAlignment(.center)
//                
//                Spacer()
//                Text("Created by Henrique Marques")
//                    .font(.footnote)
//                    .foregroundStyle(.secondary)
//                    .padding(.bottom)
//            }
//            .background(Image("SolarBackground"))
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
                //     .resizable()
                //     .scaledToFill()
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
                        
//                        NavigationLink(destination: UpcomingLaunches()) {
//                            Text("Credits")
//                                .bold()
//                                .padding()
//                        }
                        
//                        Button("Open") {
//                            openWindow(id: "ImmersiveRocketSpace")
//                        }
                        
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

#Preview(windowStyle: .automatic) {
    ContentView()
}

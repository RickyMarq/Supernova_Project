//
//  PictureDay.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 07/11/23.
//

import SwiftUI

struct PictureDay: View {

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @State var pictureOfTheDay: PictureOfTheDay?
    @Environment(ViewModel.self) var model
    @State var showAlert: Bool = false
    @State var typedText: String = ""
    @State private var alertMessage = ""
    @State var pictureOfTheDayTitle = ""
    @State var fullText = "Hello, SwiftUI! This is a typing animation."

    
    var body: some View {
        @Bindable var model = model
        
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string:  pictureOfTheDay?.url ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                Color.clear
            }
            
            Text(pictureOfTheDay?.title ?? "")
                .padding(30)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .bold()
                .lineLimit(24)
                .multilineTextAlignment(.trailing)
                .shadow(color: .black, radius: 10)
                .padding(10)
        }
        .ignoresSafeArea(.all)
        .navigationBarItems(leading:
                                
    Toggle(model.infoTitle, isOn: $model.isShowingInfo)
            .onChange(of: model.isShowingInfo) { _, isShowing in
                if isShowing {
                    openWindow(id: "pictureOfDayDetails")
                } else {
                    dismissWindow(id: "pictureOfDayDetails")
                }
            }
            .toggleStyle(.button)
        )
        
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .cancel({
                presentationMode.wrappedValue.dismiss()
            }))
        })
        
        .onAppear(perform: {
            pictureOfTheDayTitle = pictureOfTheDay?.title ?? ""
            getPictureOfTheDay()
        })
        
        .onDisappear(perform: {
            dismissWindow(id: "pictureOfDayDetails")
        })
            
    }
    
    func getPictureOfTheDay() {
        LaunchServices.sharedObjc.getPictureOfTheDay { result in
    
            switch result {
            case .success(let model):
                guard let model = model else {return}
                pictureOfTheDay = model
            case .failure(let error):
                self.alertMessage = error.rawValue
                showAlert = true
            }
        }
    }
    
    private var typingTimer: Timer {
        
          Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
              guard !self.pictureOfTheDayTitle.isEmpty else {
                  timer.invalidate()
                  return
              }

              let nextCharacter = self.pictureOfTheDayTitle.removeFirst()
              self.typedText += String(nextCharacter)

              if self.pictureOfTheDayTitle.isEmpty {
                  timer.invalidate()
              }
          }
      }

}

#Preview {
    PictureDay(pictureOfTheDay: PictureOfTheDay(date: "2024-01-06", explanation: "You couldn't really be caught in this blizzard while standing by a cliff on periodic comet 67P/Churyumov-Gerasimenko. Orbiting the comet in June of 2016, the Rosetta spacecraft's narrow angle camera did record streaks of dust and ice particles similar to snow as they drifted across the field of view close to the camera and above the comet's surface. Still, some of the bright specks in the scene are likely due to a rain of energetic charged particles or cosmic rays hitting the camera, and the dense background of stars in the direction of the constellation of the Big Dog (Canis Major). In the video, the background stars are easy to spot trailing from top to bottom. The stunning movie was constructed from 33 consecutive images taken over 25 minutes while Rosetta cruised some 13 kilometers from the comet's nucleus. In September 2016, the nucleus became the final resting place for the Rosetta spacecraft after its mission was ended with a successful controlled impact on 67P/Churyumov-Gerasimenko.", title: "The Snows of Churyumov-Gerasimenko", url: "https://static.wikia.nocookie.net/thelastofus/images/2/2f/Part_I_Bill_infobox.png/revision/latest/scale-to-width-down/700?cb=20230215182523"))
}

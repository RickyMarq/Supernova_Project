//
//  NasaObservatory.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 09/01/24.
//

import SwiftUI


struct NasaObservatory: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var pictureOfTheDayData: [PictureOfTheDay] = []
    @State var showAlert: Bool = false
    @State private var alertMessage = ""
    @State var gridItems = [StackGridItem]()
    
    var body: some View {
        
        ScrollView {
            GridLayout(gridItems: gridItems, numberofColumns: 4, spacing: 10, horizontalPadding: 20, picturesOfTheDay: pictureOfTheDayData)
                .onAppear {
                    print("DEBUG MODE: Get more Images...")
                    print("DEBUG MODE: Img Count: \(pictureOfTheDayData.count)")
                    getInitialPicturesOfTheDay(imgCount: 50)
                }
            
            VStack(alignment: .center) {
                Spacer()
                
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
                }
                Spacer()
                
            }
            .foregroundColor(Color.clear)
//            .onAppear {
//                print("DEBUG MODE: Get more Images...")
//                print("DEBUG MODE: Img Count: \(pictureOfTheDayData.count)")
//                getInitialPicturesOfTheDay(imgCount: 20)
//            }
            
            
        }
        .background(Image("SolarBackground")
            .resizable()
            .scaledToFill()
        )
        .navigationTitle("Nasa Observatory")
        
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .cancel({
                presentationMode.wrappedValue.dismiss()
            }))
        })
    }
    
    func configData() {
        for items in pictureOfTheDayData {
            let randomHeight = CGFloat.random(in: 100...400)
            gridItems.append(StackGridItem(height: randomHeight, title: items.title ?? "", description: items.explanation ?? "", imgString: items.url ?? ""))
        }
    }
    
    func getInitialPicturesOfTheDay(imgCount: Int) {
        print("Getting more data,,,,,,,")
        NasaObservatoryService.sharedObjc.getLastPicturesOfTheDays(images: imgCount) { result in
            
            switch result {
            case .success(let data):
                pictureOfTheDayData.append(contentsOf: data ?? [])
                configData()
            case .failure(let error):
                self.alertMessage = error.rawValue
                showAlert = true
            }
        }
    }
}

#Preview {
    NasaObservatory()
}

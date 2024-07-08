//
//  NasaObservatory.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 07/07/24.
//

import SwiftUI

struct NasaObservatory: View {
    
    @State private var isLoading: Bool = false
    @State var pictureOfTheDayData: [PictureOfTheDay] = []
    
    var body: some View {
        
        var gridItems = [StackGridItem]()
        for items in pictureOfTheDayData {
            let randomHeight = CGFloat.random(in: 100...400)
            gridItems.append(StackGridItem(height: randomHeight, title: items.title ?? "", description: items.explanation ?? "", imgString: items.url ?? ""))
        }
        
        return ScrollView(showsIndicators: false) {
                GridLayout(gridItems: gridItems, numberofColumns: 4, spacing: 10, horizontalPadding: 10, picturesOfTheDay: pictureOfTheDayData)
            }
                    
        .navigationTitle("Nasa Observatory")
        .onAppear(perform: {
            getInitialPicturesOfTheDay(imgCount: 50)
        })
        
        
    }
    
    func getInitialPicturesOfTheDay(imgCount: Int) {
        NasaObservatoryService.sharedObjc.getLastPicturesOfTheDays(images: imgCount) { result in
            
            switch result {
            case .success(let data):
                pictureOfTheDayData.append(contentsOf: data ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NasaObservatory()
}

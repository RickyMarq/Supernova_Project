//
//  NasaObservatoryView.swift
//  Supernova
//
//  Created by Henrique Marques on 24/01/24.
//

import SwiftUI

struct NasaObservatoryView: View {
    
    @State private var isLoading: Bool = false
    @State var pictureOfTheDayData: [PictureOfTheDay] = []
    
    var body: some View {
        
        var gridItems = [StackGridItem]()
        for items in pictureOfTheDayData {
            let randomHeight = CGFloat.random(in: 100...400)
            gridItems.append(StackGridItem(height: randomHeight, title: items.title ?? "", description: items.explanation ?? "", imgString: items.url ?? ""))
        }
        
        return ScrollView(showsIndicators: false) {
                GridLayout(gridItems: gridItems, numberofColumns: 2, spacing: 10, horizontalPadding: 10, picturesOfTheDay: pictureOfTheDayData)
//                    .onAppear {
//                        print("LOAD MORE DATA....")
//                        self.loadMoreData()
//                }
                
            }
        
        .onAppear(perform: {
            print("Load More Data?....")
        })
                    
        .navigationTitle("Nasa Observatory")
        .onAppear(perform: {
            getInitialPicturesOfTheDay(imgCount: 50)
        })
        
        
    }
    
    func getInitialPicturesOfTheDay(imgCount: Int) {
        NasaObservatoryService.sharedObjc.getLastPicturesOfTheDays(images: imgCount) { result in
            
            switch result {
            case .success(let data):
                print("DEBUG MODE: Success...")
                pictureOfTheDayData.append(contentsOf: data ?? [])
                print("DEBUG MODE Nasa Ob: \(data)")
            case .failure(let error):
                print("DEBUG MODE: Error")
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMoreData() {
        guard !isLoading else {return}
        let threshold = 0.8
        let scrollPecentage = Double(UIScrollView().contentOffset.y + UIScreen.main.bounds.height) / Double(UIScrollView().contentSize.height)
        
        if scrollPecentage > threshold {
            getInitialPicturesOfTheDay(imgCount: 5)
        }
    }
}

#Preview {
    NasaObservatoryView()
}

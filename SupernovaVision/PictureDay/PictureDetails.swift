//
//  PictureDetails.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 26/01/24.
//

import SwiftUI

struct PictureDetails: View {
    
    @State var pictureOfTheDay: PictureOfTheDay?
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                Text(pictureOfTheDay?.explanation ?? "")
                    .padding(10)
                    .lineLimit(nil)
                    .font(.headline)
                    .foregroundColor(Color.secondary)
                    .lineSpacing(10)
                    .multilineTextAlignment(.leading)
                    .multilineTextAlignment(.leading)
                
                Text("Nasa Picture of The Day")
                    .padding()
                    .font(.callout)
            }
        }
        .padding()
        .background(Image("SolarBackground")
            .resizable()
            .scaledToFill())
        
        .onAppear(perform: {
            getPictureOfTheDay()
        })
        
    }
    
    func getPictureOfTheDay() {
        LaunchServices.sharedObjc.getPictureOfTheDay { result in
    
            switch result {
            case .success(let model):
                guard let model = model else {return}
                pictureOfTheDay = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    PictureDetails()
}

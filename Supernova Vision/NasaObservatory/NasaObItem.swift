//
//  NasaObItem.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 21/01/24.
//

import SwiftUI

struct NasaObItem: View {
    
    var data: PictureOfTheDay
    
    var body: some View {
        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            let imageWidth = min(max(proxy.size.width - textWidth, 300), 700)
            ScrollView {
                ZStack {
                    HStack(spacing: 60) {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                            
                            Text(data.title ?? "")
                                .font(.extraLargeTitle)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            Text(data.explanation ?? "")
                                .font(.headline)
                                .padding()
                            
                            Spacer()
                        }
                        .frame(width: textWidth, alignment: .leading)
                        
                        AsyncImage(url: URL(string: data.url ?? "")) { image in
                            image
                                .resizable()
                                .cornerRadius(10)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 500, alignment: .center)
                                .shadow(radius: 10)
                                .glassBackgroundEffect()
                        } placeholder: {
                            
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .background(Image("SolarBackground")
            .resizable()
            .scaledToFill()
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Nasa Observatory")
    }
}

#Preview {
    NasaObItem(data: PictureOfTheDay(date: "", explanation: "", title: "", url: ""))
}

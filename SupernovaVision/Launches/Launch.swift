//
//  Launch.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 10/01/24.
//

import SwiftUI

struct Launch: View {
    
    let mock = 1..<30
    let rows = [GridItem(.flexible(minimum: 30))]
    
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.lightGray]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.lightGray]
//    }
//    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Upcoming Launches")
                        .font(.largeTitle)
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(mock, id: \.self) { item in
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                                
                        }
                    }
                    .padding()
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Past Launches")
                        .font(.largeTitle)
                }
                .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(mock, id: \.self) { item in
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .padding()
            }
        }
        .navigationTitle("Rocket Launches")
        .background(
            Image("SolarBackground")
                .resizable()
                .scaledToFill()
        )
        .padding()
    }
}

#Preview {
    Launch()
}

//
//  ContentView.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 27/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
                List {
                    ForEach(viewModel.data, id: \.id) { datum in
                        NavigationLink(destination: datum.Screen) {
                        
                        HStack {
                            Image(systemName: datum.symbol ?? "")
                                .foregroundColor(Color.accentColor)
                                
                            Text(datum.name ?? "")
                                .bold()

                            }
                        }
                    }
                 }
                .listStyle(.plain)
            .navigationTitle("Supernova")
        }
    }
}

struct HomeUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

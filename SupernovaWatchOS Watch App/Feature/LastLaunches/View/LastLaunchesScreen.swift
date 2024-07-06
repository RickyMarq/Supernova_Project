//
//  LastLaunchesScreen.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 29/06/23.
//

import SwiftUI

struct LastLaunchesScreen: View {
    
    @State var viewModel = LastLaunchesViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataObjc) { data in
                NavigationLink(destination: LaunchItem(datObjc: data)) {
                    VStack {
                        Text(data.name ?? "")
                            .bold()
                    }
                    
                }
                
            }
            
            VStack(alignment: .center) {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            .onAppear {
                viewModel.getLastLaunchesData(page: viewModel.page)
                viewModel.page += 12
            }
            
        }
        .navigationTitle("Last Launches")
        
        .onAppear {
            viewModel.getLastLaunchesData(page: viewModel.page)
        }
        
    }
}

struct LastLaunchesScreen_Previews: PreviewProvider {
    static var previews: some View {
        LastLaunchesScreen()
    }
}

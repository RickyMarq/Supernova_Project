//
//  LaunchesScreen.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 27/06/23.
//

import SwiftUI

struct LaunchesScreen: View {
    
    @State var viewModel = LaunchViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.objcData, id: \.id) { data in
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
                viewModel.getLaunchData(page: viewModel.page)
                viewModel.page += 12
            }
            
        }
        .navigationBarTitle("Launches")
        .onAppear {
            viewModel.getLaunchData(page: 1)
        }
    }
    
    struct LaunchesScreen_Previews: PreviewProvider {
        static var previews: some View {
            LaunchesScreen()
        }
    }
}

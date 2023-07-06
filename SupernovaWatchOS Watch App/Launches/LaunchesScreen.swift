//
//  LaunchesScreen.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 27/06/23.
//

import SwiftUI

struct LaunchesScreen: View {
    
    @State var objcData: [ResultedModel] = []
    @State var page = 0
    
    var body: some View {
//        NavigationView {
            List {
                ForEach(objcData, id: \.id) { data in
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
                    getLaunchData(page: page)
                    page += 12
                    print("DEBUG MODE PAGE: \(page)")
                }
//            }
            
            
                
                
                
            }
            .navigationBarTitle("Launches")
            .onAppear {
                getLaunchData(page: 1)
            }
    }
    
    func getLaunchData(page: Int) {
        AppleWatchService.sharedObjc.getFutureLauches(limit: 5, startsAt: page) { result in
            
            switch result {
                
            case .success(let data):
                objcData.append(contentsOf: data ?? [])
                
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            }
        }
    }
    
    struct LaunchesScreen_Previews: PreviewProvider {
        static var previews: some View {
            LaunchesScreen()
        }
    }
}

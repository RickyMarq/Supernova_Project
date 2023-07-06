//
//  LastLaunchesScreen.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 29/06/23.
//

import SwiftUI

struct LastLaunchesScreen: View {
    
    @State var dataObjc: [ResultedModel] = []
    @State var page = 0
    
    var body: some View {
//        NavigationView {
            List {
                ForEach(dataObjc) { data in
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
                    getLastLaunchesData(page: page)
                    page += 12
                    print("DEBUG MODE PAGE: \(page)")
                }
              
            }
            .navigationTitle("Last Launches")
         
            
            

            
  //      }
        
        
        // WatchOS 8 
//        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            getLastLaunchesData(page: page)
        }
        
        
        
     
    }
    
    
    
    func getLastLaunchesData(page: Int) {
        AppleWatchService.sharedObjc.getLastLauches(limit: page) { result in
            
            switch result {
                
            case .success(let data):
                dataObjc.append(contentsOf: data ?? [])
                
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
            
        }
    }
}

struct LastLaunchesScreen_Previews: PreviewProvider {
    static var previews: some View {
        LastLaunchesScreen()
    }
}

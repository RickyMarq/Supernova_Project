//
//  UpcomingLaunches.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 15/11/23.
//

import SwiftUI

struct UpcomingLaunches: View {
    
    @State var upcomingData: [ResultedModel] = []
    @Environment(\.presentationMode) var presentationMode
    @State var page = 0
    @State var showAlert: Bool = false
    @State private var alertMessage = ""
    
    var body: some View {
        List {
            ForEach(upcomingData) { data in
                NavigationLink(destination: LaunchViewItem(data: data)) {
                    HStack {
                        AsyncImage(url: URL(string: data.image ?? "")) { image in
                            image
                                .resizable()
                                .cornerRadius(10)
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 220, alignment: .center)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(data.name ?? "")
                                .font(.largeTitle)
                                .padding()
                            
                            Text(data.pad?.name ?? "")
                                .font(.footnote)
                                .padding()
                            
                            Text(data.lastUpdated ?? "")
                                .font(.footnote)
                                .padding()
                        }
                        
                    }
                    .padding()
                }
                .padding()
            }
            
            VStack(alignment: .center) {
                Spacer()
                
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
                }
                Spacer()
                
            }
            .foregroundColor(Color.clear)
            
            .onAppear {
                getUpcomingData(page: page)
                page += 12
            }
        }
        .navigationTitle("Upcoming Launches")
        
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .cancel({
                presentationMode.wrappedValue.dismiss()
            }))
        })
    }
    
    func getUpcomingData(page: Int) {
        LaunchServices.sharedObjc.getUpcomingLaunches(limit: 12, startsAt: page) { result in
            
            switch result {
                
            case .success(let data):
                self.upcomingData.append(contentsOf: data ?? [])
                
            case .failure(let error):
                self.alertMessage = error.rawValue
                showAlert = true
            }
        }
    }
}

#Preview {
    UpcomingLaunches()
}

//
//  ContentView.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 27/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeUI: View {
    
    @State var dataObjc: [PictureOfTheDayModel] = []

    
    @State var data: [HomeData] = [HomeData(name: "Launches", symbol: "mappin.and.ellipse", img: "", Screen: AnyView(LaunchesScreen())),
                                   HomeData(name: "Last Launches", symbol: "sparkles", img: "", Screen: AnyView(LastLaunchesScreen())), HomeData(name: "News", symbol: "newspaper", img: "", Screen: AnyView(NewsScreen())),
                                   HomeData(name: "Picture of The Day", symbol: "moon.stars", img: "IssMoon_Yang_960", Screen: AnyView(PictureOfTheDay(data: PictureOfTheDayModel(date: "", explanation: "", title: "", url: "", hdurl: ""))))]
    
    var body: some View {
        
        NavigationView {
                List {
                    ForEach(data, id: \.id) { datum in
                        NavigationLink(destination: datum.Screen) {
                        
                        HStack {
                            Image(systemName: datum.symbol ?? "")
                                .foregroundColor(Color.accentColor)
                            
                            Text(datum.name ?? "")
                                .bold()
                            
//                            if datum.img != "" {
//                                Image("IssMoon_Yang_960")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                  //  .frame(width: 50, height: 50) // Fixed size for the image
//                                    .clipped()

                                
                                    
                                    
//                                ForEach(dataObjc) { model in
//                                    HStack(alignment: .center) {
//
//                                        WebImage(url: URL(string: model.url ?? ""))
//                                            .resizable()
//                          //                  .cornerRadius(10)
//                                            .scaledToFill()
                                    }
                                    //                                            //                                        Text("Nasa Picture Of The Day")
                                    //                                            //                                            .bold()
                                    //                                            //                                            .multilineTextAlignment(.center)
                                    //                                            }
                                    //                                .listRowInsets(EdgeInsets())
 //                                   }
//                                }
//                            }
                        }
                    }
                    
                    
                    
//                footer: {
//                    VStack {
//                        Image("IssMoon_Yang_960")
//                            .resizable()
//                            .cornerRadius(10)
//                            .scaledToFill()
//                        //           .padding(.horizontal, 10)
//                        //                                .frame(width: 50)
//
//                        Text("Nasa Picture of The Day")
//                            .multilineTextAlignment(.center)
//                            .bold()
//                    }
//                }
                    
                
                        
                        
                        
                }
                .listStyle(.plain)
    //        .frame(height: WKInterfaceDevice.current().screenBounds.height)
            // WatchOS 8
            //   .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Supernova")
            
         //   .background(Color.purple)
        }
        
        .onAppear {
            getPictureOfTheDay()
           
        }
    }
    
    func getPictureOfTheDay() {
//        AppleWatchService.sharedObjc.getPictureOfTheDay { data, error in
//            guard let data = data else {return}
//            dataObjc.append(data)
//        }
    }
}

struct HomeData: Identifiable {
    var id = UUID()
    let name: String?
    let symbol: String?
    let img: String?
    let Screen: AnyView
}


struct HomeUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeUI()
    }
}

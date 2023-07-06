//
//  LaunchItem.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 28/06/23.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import UIKit

struct LaunchItem: View {
    
    var datObjc: ResultedModel
    @State var region: MKCoordinateRegion
    
    init(datObjc: ResultedModel) {
        self.datObjc = datObjc

        let lat = (datObjc.pad?.latitude as? NSString)?.doubleValue
        let lon = (datObjc.pad?.longitude as? NSString)?.doubleValue
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lon ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))

    }
    
    
    var body: some View {
//        NavigationView {
            ScrollView {
                VStack {
                    Text(datObjc.name ?? "")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
//                    if let publishedAt = datum.publishedAt {
//                        Text(publishedAt.convertHourNewsFormatter(datum.publishedAt ?? ""))
//                            .foregroundColor(Color.secondary)
//                    }
                    
                    if let date = datObjc.windowStart {
                        Text("Launch in " + date.convertDateLaunchesFormatter(datObjc.windowStart ?? ""))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                
                    if let hour = datObjc.windowStart {
                        Text(hour.convertHourLaunchesFormatter(datObjc.windowStart ?? "", outPut: "HH:mm zzz"))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom)
                        
                    }
                    
                  
                    Text("Map")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.accentColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Map(coordinateRegion: $region)
                        .cornerRadius(10)
                        .frame(height: 100)
                        .padding(.bottom)
                        .allowsHitTesting(false)
                    
                    
                    Text(datObjc.pad?.location.name ?? "")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    Text("Launch Info")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.accentColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
//                        Text("Weather: " + (datObjc.weatherConcerns ?? ""))
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(Color.accentColor)
//                        //    .bold()

                        
                        Text("Launch Count: " + String(datObjc.pad?.launchCount ?? 0))
                            .bold()

                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                        Text("Orbital Count: " + String(datObjc.pad?.orbitalLaunchCount ?? 0))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
  //                          .padding(.bottom)
                        
//                        Text(datObjc.pad?.name ?? "")
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                        Text("Launch Count: " + String(datObjc.pad?.launchCount ?? 0))
                        
                    }
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    
                    
                    Text("Image")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.accentColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    WebImage(url: URL(string: datObjc.image ?? ""))
                        .resizable()
                        .cornerRadius(10)
                        .scaledToFill()
                        .shadow(color: Color.accentColor, radius: 0.5, x: 0, y: 0.5)
                    
                    
                    
                    
                        
                    
                    
                    
//                }
            }
            
            
            .onAppear {

            }
            // WatchOS 8
            //.navigationBarTitleDisplayMode(.inline)
        }
        .navigationTitle("Launch")
        .padding(.horizontal, 5)
      
    }
    
    
   
    
}

struct LaunchItem_Previews: PreviewProvider {
    static var previews: some View {
        LaunchItem(datObjc: ResultedModel(id: "", name: "Firefly Alpha | FLTA003 (VICTUS NOX)", image: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launcher_images/firefly_alpha_image_20210429094607.jpg", lastUpdated: "", windowStart: "2023-06-29T15:28:38Z", weatherConcerns: "Cumulus Cloud Rule", pad: Pad(name: "Spaceport America", WikiUrl: "", MapImage: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/location_12_20200803142519.jpg", latitude: "34.7556", longitude: "-120.6224", launchCount: 1, orbitalLaunchCount: 1, agencyID: 1, location: Location(name: "Cape Canaveral, FL, USA")), locationLaunchAttemptCount: 1, padLaunchAttemptCount: 1, orbitalLaunchAttemptCount: 1))
    }
}
